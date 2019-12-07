class StandingOrderFragment < ActiveRecord::Base
  
  has_many :standing_order_fragment_versions, -> { order( adopted_on: :asc ) }
end
