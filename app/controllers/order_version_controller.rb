class OrderVersionController < ApplicationController
  
  def index
    @order_versions = OrderVersion.all
  end
  
  def show
    order_version = params[:order_version]
    @order_version = OrderVersion.find( order_version )
  end
end
