class AdoptionController < ApplicationController
  
  def show
    adoption = params[:adoption]
    @adoption = Adoption.find( adoption )
  end
end
