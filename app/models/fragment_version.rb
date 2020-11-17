class FragmentVersion < ActiveRecord::Base
  
  belongs_to :adoption
  belongs_to :fragment
  belongs_to :order
end
