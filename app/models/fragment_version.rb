class FragmentVersion < ActiveRecord::Base
  
  belongs_to :adoption
  belongs_to :fragment
  belongs_to :order
  belongs_to :order_version
  
  def citation_in_list
    citation_in_list = self.parlrules_identifier
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
end
