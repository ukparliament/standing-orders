require 'csv'

task :setup => [
  :import_revision_sets,
  :import_fragment_versions,
  :inflate_fragments,
  :import_order_versions,
  :inflate_orders,
  :link_fragment_versions_to_orders,
  :link_fragment_versions_to_order_versions
]

task :import_revision_sets => :environment do
  puts "importing revision sets"
  CSV.foreach( 'db/data/2.0.0/revision_sets.csv' ) do |row|
    revision_set = RevisionSet.new
    revision_set.date = row[3].to_date
    revision_set.parlrules_identifier = row[2].strip
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
      fragment_version.current_number = row[4].strip
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
      order_version.current_number = row[4].strip
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