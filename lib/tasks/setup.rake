require 'csv'

task :setup => [
  :import_adoptions,
  :import_fragment_versions,
  :inflate_fragments,
  :import_order_versions
]

task :import_adoptions => :environment do
  puts "importing adoptions"
  CSV.foreach( 'db/data/2.0.0/adoptions.csv' ) do |row|
    adoption = Adoption.new
    adoption.date = row[3].to_date
    adoption.parlrules_identifier = row[2].strip
    adoption.save
  end
end
task :import_fragment_versions => :environment do
  puts "importing fragment versions"
  CSV.foreach( 'db/data/2.0.0/fragment_versions.csv' ) do |row|
    adoption = Adoption.all.where( 'parlrules_identifier = ?', row[2].strip ).first
    if adoption
      fragment_version = FragmentVersion.new
      fragment_version.adoption = adoption
      fragment_version.parlrules_identifier = row[3].strip
      fragment_version.current_number = row[4].strip
      fragment_version.root_number = row[5].strip
      fragment_version.text = row[6].strip
      fragment_version.parlrules_article_identifier = row[7].strip
      fragment_version.article_current_number = row[8].strip
      fragment_version.article_root_number = row[9].strip
      fragment_version.save
    else
      puts "No corresponding adoption found"
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
  puts "importing fragment versions"
  CSV.foreach( 'db/data/2.0.0/order_versions.csv' ) do |row|
    adoption = Adoption.all.where( 'parlrules_identifier = ?', row[2].strip ).first
    if adoption
      order_version = OrderVersion.new
      order_version.adoption = adoption
      order_version.parlrules_identifier = row[3].strip
      order_version.current_number = row[4].strip
      order_version.root_number = row[5].strip
      order_version.text = row[6].strip
      #order_version.save
    else
      puts "No corresponding adoption found"
    end
  end
end