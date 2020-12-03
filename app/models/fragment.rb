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
    display_title = display_title + ' &mdash; Fragment ' + self.id.to_s
    display_title.html_safe
  end
end
