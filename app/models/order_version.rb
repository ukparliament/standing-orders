class OrderVersion < ActiveRecord::Base
  
  belongs_to :adoption
  belongs_to :order
  has_many :fragment_versions, -> { order( parlrules_identifier: :asc )}
  
  def display_number
    self.current_number + '.'
  end
end