class RevisionSetController < ApplicationController
  
  def index
    @revision_sets = RevisionSet.all.order( 'date asc' )
  end
  
  def show
    revision_set = params[:revision_set]
    @revision_set = RevisionSet.find( revision_set )
  end
  
  def fragment
    revision_set = params[:revision_set]
    @revision_set = RevisionSet.find( revision_set )
  end
  
  def order
    revision_set = params[:revision_set]
    @revision_set = RevisionSet.find( revision_set )
  end
end
