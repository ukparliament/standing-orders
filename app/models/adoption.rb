class Adoption < ActiveRecord::Base
  
  belongs_to :standing_order_fragment_version
  belongs_to :adoption_date
end
