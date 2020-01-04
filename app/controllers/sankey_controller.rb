class SankeyController < ApplicationController
  
  def show
    respond_to do |format|
      format.html {
        render "show", :layout => 'sankey'
      }
      format.json {
        @nodes = Node.all
        @edges = Edge.all
      }
    end
  end
end
