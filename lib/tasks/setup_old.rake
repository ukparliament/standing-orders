require 'csv'






task :inflate_flows => :environment do
  puts "inflating flows - nodes and edges"
  @node_id = 0
  node = Node.where( :id => @node_id ).first
  unless node
    node = Node.new
    node.id = @node_id
    node.label = 'Sink'
    node.save
  end
  adoption_date = AdoptionDate.all.last
  current_fragments = adoption_date.standing_order_fragment_versions
  current_fragments.each do |current_fragment|
    populate_edge( current_fragment )
  end
end
def populate_edge( current_fragment )
  edge = Edge.new
  edge.from_standing_order_fragment_version_id = current_fragment.id
  node = populate_node( current_fragment )
  edge.from_node = node.id
  if current_fragment.preceding.empty?
    edge.to_node = 0
  else
    edge.to_standing_order_fragment_version_id = current_fragment.preceding.last.id
    node = populate_node( current_fragment.preceding.last )
    edge.to_node = node.id
    populate_edge( current_fragment.preceding.last )
  end
  edge.weight = current_fragment.text.length
  edge.save
end
def populate_node( fragment )
  node = Node.where( :standing_order_fragment_version_id => fragment.id ).first
  unless node
    node = Node.new
    @node_id = @node_id + 1
    node.id = @node_id
    node.standing_order_fragment_version_id = fragment.id
    node.label = fragment.flow_label
    node.save
  end
  node
end









