class FragmentController < ApplicationController
  
  def index
    @fragments = Fragment.all
  end
  
  def show
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
end
