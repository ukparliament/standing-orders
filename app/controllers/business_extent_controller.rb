class BusinessExtentController < ApplicationController
  
  def index
    @business_extents = BusinessExtent.all
  end
  
  def show
    business_extent = params[:business_extent]
    @business_extent = BusinessExtent.find( business_extent )
    @houses = House.all
  end
  
  def house_index
    business_extent = params[:business_extent]
    @business_extent = BusinessExtent.find( business_extent )
    @houses = House.all
  end
end
