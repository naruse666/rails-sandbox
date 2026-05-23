class Product < ApplicationRecord
  include TimestampFormattable

  validates :name, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def price
    Money.new(price_cents)
  end
end
