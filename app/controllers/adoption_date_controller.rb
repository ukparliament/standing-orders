class AdoptionDateController < ApplicationController
  
  def index
    @adoption_dates = AdoptionDate.all.order( 'date asc' )
  end
  
  def show
    adoption_date = params[:adoption_date]
    @adoption_date = AdoptionDate.find( adoption_date )
  end
  
end
