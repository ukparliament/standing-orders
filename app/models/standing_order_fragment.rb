class StandingOrderFragment < ActiveRecord::Base
  
  has_many :standing_order_fragment_versions, -> { order( adopted_on: :asc ) }
  
  def inforce?
    inforce = false
    final_adoption_date = AdoptionDate.order( 'date asc' ).last
    if self.standing_order_fragment_versions.last.adoption_date == final_adoption_date
      inforce = true
    end
    inforce
  end
  def first_version
    self.standing_order_fragment_versions.first
  end
  def last_version
    self.standing_order_fragment_versions.last
  end
  def standing_order_fragment_versions_in_context
    final_adoption_date = self.last_version.adoption_date
    StandingOrderFragmentVersion.all
      .where( adoption_date: final_adoption_date)
      .where( standing_order_number_in_list: self.standing_order_fragment_versions.last.standing_order_number_in_list )
      .where( standing_order_letter_in_list: self.standing_order_fragment_versions.last.standing_order_letter_in_list )
      .order( 'fragment_number_in_list' )
  end
  def standing_order_fragment_versions_with_edits
    StandingOrderFragmentVersion.all.where( standing_order_fragment_id: self ).where( 'is_edit is true' ).order( 'adopted_on asc')
  end
end
