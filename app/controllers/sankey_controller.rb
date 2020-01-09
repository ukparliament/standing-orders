class SankeyController < ApplicationController
  
  def show
    respond_to do |format|
      format.html {
        render "show", :layout => 'sankey'
      }
      format.json {
        @nodes = Node.all.order( id: :asc )
        @edges = Edge.all.order( from_node: :asc )
      }
    end
  end
end
