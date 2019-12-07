class StandingOrderFragmentVersion < ActiveRecord::Base
  
  belongs_to :adoption_date
  belongs_to :standing_order_fragment
end
