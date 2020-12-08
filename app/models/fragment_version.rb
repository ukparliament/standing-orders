class FragmentVersion < ActiveRecord::Base
  
  belongs_to :revision_set
  belongs_to :fragment
  belongs_to :order
  belongs_to :order_version
  
  def preceding_fragment_version
    FragmentVersion.all.select( 'fv.*' ).joins( 'as fv, revision_sets as rs' ).where( 'fv.revision_set_id = rs.id').where( 'fv.fragment_id = ?', self.fragment_id).where( 'rs.ordinality < ?', self.revision_set.ordinality ).order( 'rs.ordinality desc' ).first
  end
  
  def citation_in_list
    citation_in_list = self.current_number
    # Remove -1 if it's the first fragment in an order
    citation_in_list = citation_in_list[0, citation_in_list.size - 2] if citation_in_list[citation_in_list.size - 2, 2] == '-1'
    citation_in_list
  end
  
  def display_label
    display_title = self.revision_set.display_label
    display_title = display_title + ' &mdash; Fragment version '.html_safe + self.id.to_s
  end
  
  def display_number
    display_number = ''
    # If the last 2 characters of the current number are .1 ...
    if self.current_number[self.current_number.length - 2, 2] == '-1'
      
      # ... this is the first fragment in an order so strip off the '-1'...
      display_number = self.current_number[0, self.current_number.length - 2]
      
      #... add a . for display purposes ...
      display_number += '.'
    end
  end
end
