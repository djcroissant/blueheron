class Trip < ApplicationRecord
  validates :port_city, presence: true
  validates :port_state, presence: true
  validates :port_date, presence: true
  validate  :port_date_cannot_be_in_the_past
  has_many :listings, dependent: :destroy
  belongs_to :user


  def port_date_cannot_be_in_the_past
    errors.add(:port_date, "can't be in the past") if
    !port_date.blank? && port_date <= Date.today
  end
end
