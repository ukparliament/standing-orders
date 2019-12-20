class StandingOrderFragmentVersionText < ActiveRecord::Base

	def show
  		@text = @standing_order_fragment_version_text.text?
	end
	
end
