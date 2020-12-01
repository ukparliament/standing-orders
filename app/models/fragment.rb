class Fragment < ActiveRecord::Base
  
  def fragment_versions
    FragmentVersion.all.select( 'fv.*, rs.date' ).joins( 'as fv, revision_sets as rs').where( "fv.revision_set_id = rs.id and fv.fragment_id = ?", self ).order( 'rs.date' )
  end
end
