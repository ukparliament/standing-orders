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
      display_number_in_list = 'displayed'
    else
      display_number_in_list = 'shadowed'
    end
    display_number_in_list
  end
  
  def fragment_id
    fragment_id = ''
    fragment_id = self.standing_order_number_in_list.to_s
    unless self.standing_order_letter_in_list == '-' and self.fragment_number_in_list == 1
      fragment_id = fragment_id + self.standing_order_letter_in_list if self.standing_order_letter_in_list
      fragment_id = fragment_id + self.fragment_number_in_list.to_s unless self.fragment_number_in_list == 1
    end
    fragment_id.downcase
  end
  
  def preceding
    StandingOrderFragmentVersion.all.where( standing_order_fragment_id: self.standing_order_fragment_id ).where( "adopted_on < ?", self.adopted_on ).order( 'adopted_on asc' )
  end
  
  def flow_label
    flow_label = self.adopted_on.strftime("%d-%m-%Y")
    flow_label = flow_label + ' ' + self.standing_order_number_in_list.to_s
    flow_label = flow_label + ' ' + self.standing_order_letter_in_list unless self.standing_order_letter_in_list == '-'
    flow_label = flow_label + ' ' + self.fragment_number_in_list.to_s
  end
  
end
