class FragmentController < ApplicationController
  
  def index
    @fragments = Fragment.all
  end
  
  def show
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
  
  def versions
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
  
  def revisions
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
  
  def minor_revisions
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
  
  def major_revisions
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
end
