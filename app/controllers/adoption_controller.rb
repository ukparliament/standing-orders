class AdoptionController < ApplicationController
  
  def index
    @adoptions = Adoption.all.order( 'ordinality asc' )
  end
  
  def show
    adoption = params[:adoption]
    @adoption = Adoption.find( adoption )
  end
  
  def fragment
    adoption = params[:adoption]
    @adoption = Adoption.find( adoption )
  end
  
  def order
    adoption = params[:adoption]
    @adoption = Adoption.find( adoption )
  end
end
