require 'csv'

task :setup => [
  :import_adoptions
]

task :import_adoptions => :environment do
  CSV.foreach( 'db/data/2.0.0/adoptions.csv' ) do |row|
    adoption = Adoption.new
    adoption.date = row[3].to_date
    adoption.parlrules_identifier = row[2].strip
    adoption.save
  end
end