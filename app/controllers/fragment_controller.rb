class FragmentController < ApplicationController
  
  def index
    @fragments = Fragment.all
  end
  
  def show
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
  end
  
  def redirect
    fragment = params[:fragment]
    @fragment = Fragment.find( fragment )
    if @fragment.remains_in_operation?
      fragment_version = @fragment.fragment_versions.last
      redirect_to( revision_set_show_url( :revision_set => fragment_version.revision_set, :anchor => "order-#{fragment_version.citation_in_list}" ) )
    else
      redirect_to( fragment_show_url )
    end
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
