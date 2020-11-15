class OrderController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    order = params[:order]
    @order = Order.find( order )
  end
end
