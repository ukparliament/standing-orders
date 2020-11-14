class FragmentVersion < ActiveRecord::Base
  
  belongs_to :adoption
  
  def display_number
    display_number = ''
    if self.current_number.split( '.' ).last == '01'
      display_number = self.current_number.split( '.' ).first + '.'
    end
    display_number
  end
end
