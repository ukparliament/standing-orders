class OrderVersion < ActiveRecord::Base
  
  belongs_to :revision_set
  belongs_to :order
  has_many :fragment_versions, -> { order( ordinality: :asc )}
  
  def preceding_order_version
    OrderVersion.all.select( 'ov.*' ).joins( 'as ov, revision_sets as rs' ).where( 'ov.revision_set_id = rs.id and ov.order_id = ?', self.order_id ).where( 'rs.ordinality < ?', self.revision_set.ordinality ).order( 'rs.ordinality desc' ).first
  end
  
  def citation_in_list
    citation_in_list = self.fragment_versions.first.current_number
    # Remove -1 if it's the first fragment in an order
    citation_in_list = citation_in_list[0, citation_in_list.size - 2] if citation_in_list[citation_in_list.size - 2, 2] == '-1'
    citation_in_list
  end
  
  def display_title
    display_title = self.revision_set.display_label
    display_title = display_title + ' &mdash; Order version '.html_safe + self.id.to_s
  end
end