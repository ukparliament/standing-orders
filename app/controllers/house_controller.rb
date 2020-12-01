class HouseController < ApplicationController
  
  def index
    @houses = House.all
  end
  
  def show
    house = params[:house]
    @house = House.find( house )
    @business_extents = BusinessExtent.all
  end
  
  def business_extent_index
    house = params[:house]
    @house = House.find( house )
    @business_extents = BusinessExtent.all
  end
  
  def business_extent_show
    house = params[:house]
    @house = House.find( house )
    business_extent = params[:business_extent]
    @business_extent = BusinessExtent.find( business_extent )
  end
  
  def business_extent_revision_set_list
    house = params[:house]
    @house = House.find( house )
    business_extent = params[:business_extent]
    @business_extent = BusinessExtent.find( business_extent )
  end
end
