class OrderVersion < ActiveRecord::Base
  
  belongs_to :revision_set
  belongs_to :order
  has_many :fragment_versions, -> { order( parlrules_identifier: :asc )}
  
  def display_number
    self.current_number + '.'
  end
  
  def display_title
    display_title = self.revision_set.display_label
    display_title = display_title + ' &mdash; Order version '.html_safe + self.id.to_s
  end
end