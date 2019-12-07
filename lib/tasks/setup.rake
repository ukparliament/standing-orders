#require 'CSV'

task :setup => [
  :import_from_spreadsheet,
  :inflate_adoption_dates,
  :inflate_adoptions,
  :split_out_numbers_and_letters] do
end

task :import_from_spreadsheet => :environment do
  puts "importing raw data from spreadsheet"
  CSV.foreach( 'db/data/sos.csv' ) do |row|
    standing_order_fragment_version = StandingOrderFragmentVersion.new
    standing_order_fragment_version.id = row[0]
    standing_order_fragment_version.text = row[1]
    standing_order_fragment_version.adopted_on = row[2].to_date
    standing_order_fragment_version.current_number = row[3]
    standing_order_fragment_version.root_number = row[4]
    standing_order_fragment_version.reference = row[5]
    standing_order_fragment_version.year = row[6]
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
task :inflate_adoptions => :environment do
  puts "inflating adoptions"
  standing_order_fragment_versions = StandingOrderFragmentVersion.all
  standing_order_fragment_versions.each do |standing_order_fragment_version|
    adoption = Adoption.new
    adoption.standing_order_fragment_version = standing_order_fragment_version
    adoption.adoption_date = standing_order_fragment_version.adoption_date
    adoption.standing_order_number = standing_order_fragment_version.current_number.split( '.', ).first
    adoption.fragment_number_in_list = standing_order_fragment_version.current_number.split( '.', ).last
    adoption.save
  end
end
task :split_out_numbers_and_letters => :environment do
  puts "splitting out so numbers and letters"
  adoptions = Adoption.all
  adoptions.each do |adoption|
    if adoption.standing_order_number.match(/^(\d)+$/)
      adoption.standing_order_number_in_list = adoption.standing_order_number.to_i
      adoption.standing_order_letter_in_list = '-'
    else
      adoption.standing_order_number_in_list = adoption.standing_order_number[0, adoption.standing_order_number.length - 1]
      adoption.standing_order_letter_in_list = adoption.standing_order_number[adoption.standing_order_number.length - 1, 1]
    end
    adoption.save
  end
end






# inflate standing order versions into standing orders
task :inflate_standing_orders => :environment do
  puts "inflating standing orders from versions"
  standing_order_versions = StandingOrderVersion.all
  standing_order_versions.each do |standing_order_version|
    standing_order = StandingOrder.find( standing_order.root_number )
    unless standing_order
      standing_order = StandingOrder.new
      standing_order.id = standing_order_version.root_number
      standing_order.save
    end
    standing_order_version.standing_order = standing_order
    standing_order_version.save
  end
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






