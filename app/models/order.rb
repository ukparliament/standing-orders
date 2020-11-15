class Order < ActiveRecord::Base
  
  def order_versions
    OrderVersion.all.select( 'ov.*, a.date' ).joins( 'as ov, adoptions as a').where( "ov.adoption_id = a.id and ov.order_id = ?", self ).order( 'a.date' )
  end
end
