class Adoption < ActiveRecord::Base
  
  has_many :fragment_versions

  def display_date
    day_format = ActiveSupport::Inflector.ordinalize(date.day)
    date.strftime("<span class='b'>%Y</span> &mdash; #{day_format} %B").html_safe
  end
end
