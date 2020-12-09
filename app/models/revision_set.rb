class RevisionSet < ActiveRecord::Base
  
  belongs_to :house
  belongs_to :business_extent
  has_many :fragment_versions, -> { order( ordinality: :asc )}
  has_many :order_versions, -> { order( ordinality: :asc )}

  def display_date
    day_format = ActiveSupport::Inflector.ordinalize(date.day)
    date.strftime("<span class='b'>%Y</span> &mdash; #{day_format} %B").html_safe
  end

  def display_label
    display_label = self.house.name + ' &mdash; ' + self.business_extent.label + ' &mdash; ' + self.display_date
    display_label.html_safe
  end
end