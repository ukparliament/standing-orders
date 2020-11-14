class FragmentController < ApplicationController
  
  def show
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
end
