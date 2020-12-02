class RevisionController < ApplicationController
  
  def index
    @revisions = Revision.all
  end
  
  def show
    revision = params[:revision]
    @revision = Revision.find( revision )
  end
end
