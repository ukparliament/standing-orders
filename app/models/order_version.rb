class OrderVersion < ActiveRecord::Base
  
  belongs_to :revision_set
  belongs_to :order
  has_many :fragment_versions, -> { order( parlrules_identifier: :asc )}
  
  # todo: can this be generated from 'current number'
  def citation_in_list
    citation_in_list = self.fragment_versions.first.parlrules_identifier
    # swap . for -
    citation_in_list = citation_in_list.gsub( '.', '-' )
    # remove any zeros in tenths column
    citation_in_list = citation_in_list.gsub( '-0', '-' )
    # remove any zeros in units column
    citation_in_list = citation_in_list.gsub( '0-', '-' )
    # remove leading 0s
    while ( citation_in_list[0,1] == '0' )
      citation_in_list = citation_in_list[1, citation_in_list.size]
    end
    # Remove -1 if it's the first fragment in an order
    citation_in_list = citation_in_list[0, citation_in_list.size - 2] if citation_in_list[citation_in_list.size - 2, 2] == '-1'
    citation_in_list
  end
  
  def display_number
    self.current_number + '.'
  end
  
  def display_title
    display_title = self.revision_set.display_label
    display_title = display_title + ' &mdash; Order version '.html_safe + self.id.to_s
  end
end