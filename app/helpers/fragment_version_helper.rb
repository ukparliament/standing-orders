module FragmentVersionHelper
  
  def display_order_link( fragment_version )
    display_number = ''
    if fragment_version.current_number.split( '.' ).last == '01'
      display_number = link_to( fragment_version.current_number.split( '.' ).first + '.', order_show_url( :order => fragment_version.order ) )
    end
    display_number
  end
end
