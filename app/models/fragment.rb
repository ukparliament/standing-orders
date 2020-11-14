class Fragment < ActiveRecord::Base
  
  def fragment_versions
    FragmentVersion.all.select( 'fv.*, a.date' ).joins( 'as fv, adoptions as a').where( "fv.adoption_id = a.id and fv.fragment_id = ?", self ).order( 'a.date' )
  end
end
