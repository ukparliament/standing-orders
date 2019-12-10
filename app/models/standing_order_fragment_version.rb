class StandingOrderFragmentVersion < ActiveRecord::Base
  
  belongs_to :adoption_date
  belongs_to :standing_order_fragment
  belongs_to :standing_order_fragment_version_text
  
  def number_with_letter
    number_with_letter = self.standing_order_number_in_list.to_s
    unless self.standing_order_letter_in_list == '-'
      number_with_letter = number_with_letter + self.standing_order_letter_in_list
    end
    number_with_letter
  end
  
  def display_number_with_letter
    display_number_in_list = ''
    if self.fragment_number_in_list == 1
      display_number_in_list = 'display'
    else
      display_number_in_list = 'hide'
    end
    display_number_in_list
  end
end
