class HomeController < ApplicationController
  
  def index
    @adoption_dates = AdoptionDate.all.order( 'date desc' )
  end
end
