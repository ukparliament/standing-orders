class StandingOrderFragmentController < ApplicationController
  
  def index
    @standing_order_fragments = StandingOrderFragment.all.order( 'id' )
  end
  
  def show
    standing_order_fragment = params[:standing_order_fragment]
    @standing_order_fragment = StandingOrderFragment.find( standing_order_fragment )
  end
  
end
