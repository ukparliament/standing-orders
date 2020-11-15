class OrderVersion < ActiveRecord::Base
  
  belongs_to :adoption
  
  def display_number
    self.current_number + '.'
  end
end
