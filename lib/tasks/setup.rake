require 'csv'

task :setup => [
  :import_revision_sets,
  :import_fragment_versions,
  :inflate_fragments,
  :import_order_versions,
  :inflate_orders,
  :link_fragment_versions_to_orders,
  :link_fragment_versions_to_order_versions,
  :inflate_fragment_version_revisions,
  :populate_order_version_ordinality,
  :populate_fragment_version_ordinality,
  :inflate_flows
]

task :import_revision_sets => :environment do
  puts "importing revision sets"
  CSV.foreach( 'db/data/2.0.0/revision_sets.csv' ) do |row|
    revision_set = RevisionSet.new
    revision_set.date = row[3].to_date
    revision_set.parlrules_identifier = row[2].strip
    revision_set.house_id = 1
    revision_set.business_extent_id = 1
    revision_set.save
  end
end
task :import_fragment_versions => :environment do
  puts "importing fragment versions"
  CSV.foreach( 'db/data/2.0.0/fragment_versions.csv' ) do |row|
    revision_set = RevisionSet.all.where( 'parlrules_identifier = ?', row[2].strip ).first
    if revision_set
      fragment_version = FragmentVersion.new
      fragment_version.revision_set = revision_set
      fragment_version.parlrules_identifier = row[3].strip
      current_number = row[4].strip
      # swap out the . separator for a -
      current_number.gsub!( '.', '-' )
      # remove any 0 in tenths column
      current_number.gsub!( '-0', '-' )
      fragment_version.current_number = current_number
      fragment_version.root_number = row[5].strip
      fragment_version.text = row[6].strip
      fragment_version.parlrules_article_identifier = row[7].strip
      fragment_version.article_current_number = row[8].strip
      fragment_version.article_root_number = row[9].strip
      fragment_version.save
    else
      puts "No corresponding revision set found"
    end
  end
end
task :inflate_fragments => :environment do
  puts "inflating fragments from fragment versions"
  fragment_versions = FragmentVersion.all
  fragment_versions.each do |fragment_version|
    fragment = Fragment.all.where( 'parlrules_identifier =?', fragment_version.root_number ).first
    if fragment
      fragment_version.fragment = fragment
    else
      fragment = Fragment.new
      fragment.parlrules_identifier = fragment_version.root_number
      fragment.save
    end
    fragment_version.fragment = fragment
    fragment_version.save
  end
end
task :import_order_versions => :environment do
  puts "importing order versions"
  CSV.foreach( 'db/data/2.0.0/order_versions.csv' ) do |row|
    revision_set = RevisionSet.all.where( 'parlrules_identifier = ?', row[2].strip ).first
    if revision_set
      order_version = OrderVersion.new
      order_version.revision_set = revision_set
      order_version.parlrules_identifier = row[3].strip
      order_version.root_number = row[5].strip
      order_version.save
    else
      puts "No corresponding revision set found"
    end
  end
end
task :inflate_orders => :environment do
  puts "inflating orders from order versions"
  order_versions = OrderVersion.all
  order_versions.each do |order_version|
    order = Order.all.where( 'parlrules_identifier =?', order_version.root_number ).first
    if order
      order_version.order = order
    else
      order = Order.new
      order.parlrules_identifier = order_version.root_number
      order.house_id = 1
      order.business_extent_id = 1
      order.save
    end
    order_version.order = order
    order_version.save
  end
end
task :link_fragment_versions_to_orders => :environment do
  puts "linking fragment versions to orders"
  fragment_versions = FragmentVersion.all
  fragment_versions.each do |fragment_version|
    order = Order.all.where( 'parlrules_identifier = ?', fragment_version.article_root_number ).first
    if order
      fragment_version.order = order
      fragment_version.save
    else
      puts "Unable to find order associated with fragment version"
    end
  end
end
task :link_fragment_versions_to_order_versions => :environment do
  puts "linking fragment versions to order versions"
  fragment_versions = FragmentVersion.all
  fragment_versions.each do |fragment_version|
    order_version = OrderVersion.all.where( 'parlrules_identifier = ? and revision_set_id = ?', fragment_version.parlrules_article_identifier, fragment_version.revision_set_id ).first
    if order_version
      fragment_version.order_version = order_version
      fragment_version.save
    else
      puts "Unable to find order version associated with fragment version"
    end
  end
end
task :inflate_fragment_version_revisions => :environment do
  puts "inflating fragment version revisions"
  fragments = Fragment.all
  fragments.each do |fragment|
    fragment.fragment_versions.each do |fragment_version|
      if fragment_version.preceding_fragment_version
        if fragment_version.text != fragment_version.preceding_fragment_version.text
          revision = Revision.new
          revision.from_fragment_version_id = fragment_version.preceding_fragment_version.id
          revision.to_fragment_version_id = fragment_version.id
          if fragment_version.text.downcase != fragment_version.preceding_fragment_version.text.downcase
            revision.is_major = true
          end
          revision.save
        end
      end
    end
  end
end
task :populate_order_version_ordinality => :environment do
  puts "Populating ordinality within revision sets for order versions"
  revision_sets = RevisionSet.all
  revision_sets.each do |revision_set|
    ordinality = 0
    revision_set.order_versions.each do |order_version|
      ordinality += 1
      order_version.ordinality = ordinality
      order_version.save
    end
  end
end
task :populate_fragment_version_ordinality => :environment do
  puts "Populating ordinality within revision sets for fragment versions"
  revision_sets = RevisionSet.all
  revision_sets.each do |revision_set|
    ordinality = 0
    revision_set.fragment_versions.each do |fragment_version|
      ordinality += 1
      fragment_version.ordinality = ordinality
      fragment_version.save
    end
  end
end



task :inflate_flows => :environment do
  puts "Inflating flows: nodes and edges"
  
  # Set the start node id to 0
  @node_id = 0
  
  # Make a sink node to soak up orders with no preceding order
  node = Node.new
  node.id = @node_id
  node.label = 'Sink'
  node.save
  
  # Get the last revision set
  revision_set = RevisionSet.order( 'ordinality' ).last
  
  # Loop through order versions in revision set
  revision_set.order_versions.each do |order_version|
    populate_edge( order_version )
  end
end
def populate_edge( order_version )
  
  # Populate a node for this order version
  node = populate_node( order_version )
  
  # There must be a new edge to somewhere. Even if it is to the sink
  edge = Edge.new
  edge.from_order_version_id = order_version.id
  edge.from_node = node.id
  
  # If this order versions has a preceding version ....
  if order_version.preceding_order_version
    
    #... populate a node with the preceding order verion
    node = populate_node( order_version.preceding_order_version )
    
    # ...and set the the edge to point at that node
    edge.to_order_version_id = order_version.preceding_order_version.id
    edge.to_node = node.id
    
    #...go and do all the same for the preceding order version
    populate_edge( order_version.preceding_order_version )
  
  # Otherwise there is no precedning order version ...
  else
    
    # ... so send the output to the sink
    edge.to_node = 0
  end
  
  # Populate edge weight with word count of source node
  edge.weight = order_version.word_count
  
  # Save the edge
  edge.save
end
def populate_node( order_version )
  # Try to find a node with this order version id
  node = Node.where( :order_version_id => order_version.id ).first
  
  # If there is no such node
  unless node
    
    # create one....
    node = Node.new
    @node_id = @node_id + 1
    node.id = @node_id
    node.order_version_id = order_version.id
    node.label = 'SO ' + order_version.fragment_versions.first.display_number[0, order_version.fragment_versions.first.display_number.length - 1] + ' (' + order_version.revision_set.date.to_s + ')'
    node.save
  end
  node
end