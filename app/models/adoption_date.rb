class AdoptionDate < ActiveRecord::Base
  has_many :standing_order_fragment_versions, -> { order(standing_order_number_in_list: :asc, standing_order_letter_in_list: :asc, fragment_number_in_list: :asc) }

  def display_date
    day_format = ActiveSupport::Inflector.ordinalize(date.day)
    date.strftime("%Y &mdash; #{day_format} %B").html_safe
  end
end
