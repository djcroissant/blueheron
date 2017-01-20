class Listing < ApplicationRecord
  validates :name, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  validate  :caught_by_date_cannot_be_in_the_future

  def caught_by_date_cannot_be_in_the_future
    errors.add(:date_caught, "can't be in the future") if
    !date_caught.blank? && date_caught > Date.today
  end
end
