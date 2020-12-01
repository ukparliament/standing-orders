class Order < ActiveRecord::Base
  
  belongs_to :house
  belongs_to :business_extent
  
  def order_versions
    OrderVersion.all.select( 'ov.*, rs.date' ).joins( 'as ov, revision_sets as rs').where( "ov.revision_set_id = rs.id and ov.order_id = ?", self ).order( 'rs.date' )
  end
end
