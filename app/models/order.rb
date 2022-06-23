class Order < ActiveRecord::Base
  
  #belongs_to :house
  #belongs_to :business_extent
  
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
    display_title = ''
    #display_title = self.house.name + ' &mdash; ' + self.business_extent.label
    display_title = display_title + ' &mdash; Order ID:' + self.id.to_s
    display_title.html_safe
  end

  def remains_in_operation?
    # Default to false
    remains_in_operation = false
    
    # Find the last known revision set
    last_revision_set = RevisionSet.all.order( 'ordinality' ).last
    
    # Find a version of this order in that revision set, if any
    order_version = OrderVersion.where( 'revision_set_id = ? and order_id = ?', last_revision_set.id, self.id ).first
    
    # Set result to true if there is such an order version
    remains_in_operation = true if order_version
    
    # Return true or false
    remains_in_operation
  end
end
