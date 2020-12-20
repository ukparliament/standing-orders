class Fragment < ActiveRecord::Base
  
  def fragment_versions
    FragmentVersion.all.select( 'fv.*, rs.date' ).joins( 'as fv, revision_sets as rs').where( "fv.revision_set_id = rs.id and fv.fragment_id = ?", self ).order( 'rs.ordinality' )
  end
  
  def fragment_versions_with_revisions
    FragmentVersion.all.select( 'fv.*, rs.date' ).joins( 'as fv, revision_sets as rs, revisions as r' ).where( "fv.revision_set_id = rs.id and fv.fragment_id = ? and fv.id = r.from_fragment_version_id", self ).order( 'rs.ordinality' )
  end
  
  def fragment_versions_with_minor_revisions
    FragmentVersion.all.select( 'fv.*, rs.date' ).joins( 'as fv, revision_sets as rs, revisions as r' ).where( "fv.revision_set_id = rs.id and fv.fragment_id = ? and fv.id = r.from_fragment_version_id and r.is_major is false", self ).order( 'rs.ordinality' )
  end
  
  def fragment_versions_with_major_revisions
    FragmentVersion.all.select( 'fv.*, rs.date' ).joins( 'as fv, revision_sets as rs, revisions as r' ).where( "fv.revision_set_id = rs.id and fv.fragment_id = ? and fv.id = r.from_fragment_version_id and r.is_major is true", self ).order( 'rs.ordinality' )
  end
  
  def display_title
    display_title = self.fragment_versions.first.order.house.name + ' &mdash; ' + self.fragment_versions.first.order.business_extent.label
    display_title = display_title + ' &mdash; Fragment ID:' + self.id.to_s
    display_title.html_safe
  end

  def remains_in_operation?
    # Default to false
    remains_in_operation = false
    
    # Find the last known revision set
    last_revision_set = RevisionSet.all.order( 'ordinality' ).last
    
    # Find a version of this fragment in that revision set, if any
    fragment_version = FragmentVersion.where( 'revision_set_id = ? and fragment_id = ?', last_revision_set.id, self.id ).first
    
    # Set result to true if there is such an fragment version
    remains_in_operation = true if fragment_version
    
    # Return true or false
    remains_in_operation
  end
end
