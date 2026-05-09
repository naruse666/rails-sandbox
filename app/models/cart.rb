class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_cents
    cart_items.includes(:product).sum { |item| item.product.price_cents * item.quantity }
  end

  def total
    cart_items.includes(:product).sum(Money.zero) { |item| item.subtotal }
  end

  def total_quantity
    cart_items.sum(:quantity)
  end
end
