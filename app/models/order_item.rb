class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }

  def price
    Money.new(price_cents)
  end

  def subtotal
    price * quantity
  end
end
