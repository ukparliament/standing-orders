class House < ActiveRecord::Base
  
  def revision_sets_for_business_extent( business_extent)
    RevisionSet.all.where( 'house_id =?', self).where( 'business_extent_id = ?', business_extent ).order( 'ordinality' )
  end
end
