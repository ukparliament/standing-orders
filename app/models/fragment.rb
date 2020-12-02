class Fragment < ActiveRecord::Base
  
  def fragment_versions
    FragmentVersion.all.select( 'fv.*, rs.date' ).joins( 'as fv, revision_sets as rs').where( "fv.revision_set_id = rs.id and fv.fragment_id = ?", self ).order( 'rs.date' )
  end
  
  def display_title
    display_title = self.fragment_versions.first.order.house.name + ' &mdash; ' + self.fragment_versions.first.order.business_extent.label
    display_title = display_title + ' &mdash; Fragment ' + self.id.to_s
    display_title.html_safe
  end
end
