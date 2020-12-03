class Order < ActiveRecord::Base
  
  belongs_to :house
  belongs_to :business_extent
  
  def order_versions
    OrderVersion.all.select( 'ov.*, rs.date' ).joins( 'as ov, revision_sets as rs').where( "ov.revision_set_id = rs.id and ov.order_id = ?", self ).order( 'rs.date' )
  end
  
  def order_versions_with_revisions
    OrderVersion.all.select( 'ov.*, rs.date' ).joins( 'as ov, revision_sets as rs, fragment_versions as fv, revisions as r').where( "ov.revision_set_id = rs.id and ov.order_id = ? and ov.id = fv.order_version_id and r.from_fragment_version_id = fv.id", self ).order( 'rs.date' )
  end
  
  def order_versions_with_minor_revisions
    OrderVersion.all.select( 'ov.*, rs.date' ).joins( 'as ov, revision_sets as rs, fragment_versions as fv, revisions as r').where( "ov.revision_set_id = rs.id and ov.order_id = ? and ov.id = fv.order_version_id and r.from_fragment_version_id = fv.id and r.is_major is false", self ).order( 'rs.date' )
  end
  
  def order_versions_with_major_revisions
    OrderVersion.all.select( 'ov.*, rs.date' ).joins( 'as ov, revision_sets as rs, fragment_versions as fv, revisions as r').where( "ov.revision_set_id = rs.id and ov.order_id = ? and ov.id = fv.order_version_id and r.from_fragment_version_id = fv.id and r.is_major is true", self ).order( 'rs.date' )
  end
  
  def display_title
    display_title = self.house.name + ' &mdash; ' + self.business_extent.label
    display_title = display_title + ' &mdash; Order ' + self.id.to_s
    display_title.html_safe
  end
end
