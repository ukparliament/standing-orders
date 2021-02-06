class OrderController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    order = params[:order]
    @order = Order.find( order )
  end
  
  def redirect
    order = params[:order]
    @order = Order.find( order )
    if @order.remains_in_operation?
      order_version = @order.order_versions.last
      redirect_to( revision_set_show_url( :revision_set => order_version.revision_set, :anchor => "order-#{order_version.citation_in_list}" ) )
    else
      redirect_to( order_show_url )
    end
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
