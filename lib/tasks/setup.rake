require 'csv'

task :setup => [
  :import_from_spreadsheet,
  :inflate_adoption_dates,
  :split_out_fragment_number,
  :split_out_numbers_and_letters,
  :inflate_standing_order_fragments,
  :normalise_text_from_fragment_versions,
  :check_for_edits,
  :inflate_flows] do
end

task :import_from_spreadsheet => :environment do
  puts "importing raw data from spreadsheet"
  CSV.foreach( 'db/data/sos.csv' ) do |row|
    standing_order_fragment_version = StandingOrderFragmentVersion.new
    standing_order_fragment_version.id = row[0]
    standing_order_fragment_version.text = row[1]
    standing_order_fragment_version.adopted_on = row[6].to_date
    standing_order_fragment_version.current_number = row[3]
    standing_order_fragment_version.root_number = row[2]
    standing_order_fragment_version.reference = row[5]
    standing_order_fragment_version.year = row[4]
    standing_order_fragment_version.save
  end
end
task :inflate_adoption_dates => :environment do
  puts "inflating adoption dates from version data"
  standing_order_fragment_versions = StandingOrderFragmentVersion.all
  standing_order_fragment_versions.each do |standing_order_fragment_version|
    adoption_date = AdoptionDate.all.where( id: standing_order_fragment_version.reference ).first
    unless adoption_date
      adoption_date = AdoptionDate.new
      adoption_date.id = standing_order_fragment_version.reference
      adoption_date.date = standing_order_fragment_version.adopted_on
      adoption_date.save
    end
    standing_order_fragment_version.adoption_date = adoption_date
    standing_order_fragment_version.save
  end
end
task :split_out_fragment_number => :environment do
  puts "splitting out fragment number"
  standing_order_fragment_versions = StandingOrderFragmentVersion.all
  standing_order_fragment_versions.each do |standing_order_fragment_version|
    standing_order_fragment_version.standing_order_number = standing_order_fragment_version.current_number.split( '.', ).first
    standing_order_fragment_version.fragment_number_in_list = standing_order_fragment_version.current_number.split( '.', ).last
    standing_order_fragment_version.save
  end
end
task :split_out_numbers_and_letters => :environment do
  puts "splitting out so numbers and letters"
  standing_order_fragment_versions = StandingOrderFragmentVersion.all
  standing_order_fragment_versions.each do |standing_order_fragment_version|
    if standing_order_fragment_version.standing_order_number.match(/^(\d)+$/)
      standing_order_fragment_version.standing_order_number_in_list = standing_order_fragment_version.standing_order_number.to_i
      standing_order_fragment_version.standing_order_letter_in_list = '-'
    else
      standing_order_fragment_version.standing_order_number_in_list = standing_order_fragment_version.standing_order_number[0, standing_order_fragment_version.standing_order_number.length - 1]
      standing_order_fragment_version.standing_order_letter_in_list = standing_order_fragment_version.standing_order_number[standing_order_fragment_version.standing_order_number.length - 1, 1]
    end
    standing_order_fragment_version.save
  end
end
task :inflate_standing_order_fragments => :environment do
  puts "inflating standing order fragments from standing order fragment versions"
  standing_order_fragment_versions = StandingOrderFragmentVersion.all
  standing_order_fragment_versions.each do |standing_order_fragment_version|
    standing_order_fragment = StandingOrderFragment.all.where( id: standing_order_fragment_version.root_number ).first
    unless standing_order_fragment
      standing_order_fragment = StandingOrderFragment.new
      standing_order_fragment.id = standing_order_fragment_version.root_number
      standing_order_fragment.save
    end
    standing_order_fragment_version.standing_order_fragment = standing_order_fragment
    standing_order_fragment_version.save
  end
end
task :normalise_text_from_fragment_versions => :environment do
  puts "normalising text from standing order fragment versions"
  standing_order_fragments = StandingOrderFragment.all
  standing_order_fragments.each do |standing_order_fragment|
    standing_order_fragment.standing_order_fragment_versions.each do |standing_order_fragment_version|
      standing_order_fragment_version_text = StandingOrderFragmentVersionText.all.where( text: standing_order_fragment_version.text.strip ).where( downcase_text: standing_order_fragment_version.text.strip.downcase ).first
      unless standing_order_fragment_version_text
        standing_order_fragment_version_text = StandingOrderFragmentVersionText.new
        standing_order_fragment_version_text.text = standing_order_fragment_version.text.strip
        standing_order_fragment_version_text.downcase_text = standing_order_fragment_version.text.strip.downcase
        standing_order_fragment_version_text.save
      end
      standing_order_fragment_version.standing_order_fragment_version_text = standing_order_fragment_version_text
      standing_order_fragment_version.save
    end
  end
end
task :check_for_edits => :environment do 
  puts "checking text for edits"
  standing_order_fragments = StandingOrderFragment.all
  standing_order_fragments.each do |standing_order_fragment|
    standing_order_fragment.standing_order_fragment_versions.each do |standing_order_fragment_version|
      if standing_order_fragment_version.preceding.size > 0
        standing_order_fragment_version.is_edit = false
        if standing_order_fragment_version.standing_order_fragment_version_text.downcase_text.strip != standing_order_fragment_version.preceding.last.standing_order_fragment_version_text.downcase_text.strip
          standing_order_fragment_version.is_edit = true
          standing_order_fragment_version.save
        end
      end
    end
  end
end
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






# do all versions with the same date have the same reference? they do
task :check_references_unique_to_adoption_rates => :environment do
  adoption_dates = AdoptionDate.all
  adoption_dates.each do |adoption_date|
    reference = adoption_date.standing_order_versions.first.reference
    adoption_date.standing_order_versions.each do |standing_order_version|
      puts "oops" if standing_order_version.reference != reference
    end
  end
end
# do all current numbers have only one .?
task :check_current_numbers_have_two_level_depth => :environment do
  standing_order_fragment_versions = StandingOrderFragmentVersion.all
  standing_order_fragment_versions.each do |standing_order_fragment_version|
    if standing_order_fragment_version.current_number.split( '.' ).size != 2
      puts 'oops'
    end
  end
end






