class OrderController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    order = params[:order]
    @order = Order.find( order )
  end
  
  def versions
    order = params[:order]
    @order = Order.find( order )
  end
  
  def revisions
    order = params[:order]
    @order = Order.find( order )
  end
  
  def minor_revisions
    order = params[:order]
    @order = Order.find( order )
  end
  
  def major_revisions
    order = params[:order]
    @order = Order.find( order )
  end
end
