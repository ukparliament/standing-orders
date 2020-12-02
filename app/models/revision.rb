class Revision < ActiveRecord::Base
  
  def from_fragment_version
    FragmentVersion.all.where( 'id =?', self.from_fragment_version_id ).first
  end
  
  def to_fragment_version
    FragmentVersion.all.where( 'id =?', self.to_fragment_version_id ).first
  end
end
