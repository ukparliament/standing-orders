class HomeController < ApplicationController
  
  def index
    @revision_sets = RevisionSet.all.order( 'ordinality asc' )
  end
end
