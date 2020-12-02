class Order < ActiveRecord::Base
  
  belongs_to :house
  belongs_to :business_extent
  
  def order_versions
    OrderVersion.all.select( 'ov.*, rs.date' ).joins( 'as ov, revision_sets as rs').where( "ov.revision_set_id = rs.id and ov.order_id = ?", self ).order( 'rs.date' )
  end
  
  def display_title
    display_title = self.house.name + ' &mdash; ' + self.business_extent.label
    display_title = display_title + ' &mdash; Order ' + self.id.to_s
    display_title.html_safe
  end
end
