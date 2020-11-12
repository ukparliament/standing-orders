class HomeController < ApplicationController
  
  def index
    @adoptions = Adoption.all.order( 'ordinality asc' )
  end
end
