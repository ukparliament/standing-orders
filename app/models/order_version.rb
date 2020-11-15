class OrderVersion < ActiveRecord::Base
  
  belongs_to :adoption
  belongs_to :order
  
  def display_number
    self.current_number + '.'
  end
end
