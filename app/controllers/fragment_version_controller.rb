class FragmentVersionController < ApplicationController
  
  def index
    @fragment_versions = FragmentVersion.all
  end
  
  def show
    fragment_version = params[:fragment_version]
    @fragment_version = FragmentVersion.find( fragment_version )
  end
end
