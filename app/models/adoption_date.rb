class AdoptionDate < ActiveRecord::Base
  
  has_many :standing_order_fragment_versions, -> { order(standing_order_number_in_list: :asc, standing_order_letter_in_list: :asc, fragment_number_in_list: :asc) }
end
