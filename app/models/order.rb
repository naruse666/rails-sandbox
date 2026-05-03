class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy

  STATUSES = %w[pending paid shipped completed cancelled].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :total_cents, numericality: { greater_than_or_equal_to: 0 }

  after_create :send_confirmation_email

  def self.place!(user:, address:)
    cart = user.cart
    raise 'カートが空です' if cart.nil? || cart.cart_items.empty?

    transaction do
      cart.cart_items.includes(:product).each do |item|
        raise "在庫が不足しています: #{item.product.name}" if item.product.stock < item.quantity
      end

      total = cart.cart_items.includes(:product).sum do |item|
        item.product.price_cents * item.quantity
      end

      order = create!(
        user: user,
        address: address,
        status: 'pending',
        total_cents: total
      )

      cart.cart_items.includes(:product).each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price_cents: item.product.price_cents
        )
        item.product.update!(stock: item.product.stock - item.quantity)
      end

      cart.cart_items.destroy_all

      order
    end
  end

  def cancellable?
    %w[pending paid].include?(status)
  end

  def cancel!
    raise 'この注文はキャンセルできません' unless cancellable?

    transaction do
      order_items.includes(:product).each do |item|
        item.product.update!(stock: item.product.stock + item.quantity)
      end
      update!(status: 'cancelled')
    end
  end

  def status_label
    case status
    when 'pending' then '注文受付'
    when 'paid' then '支払い済み'
    when 'shipped' then '発送済み'
    when 'completed' then '完了'
    when 'cancelled' then 'キャンセル'
    end
  end

  private

  def send_confirmation_email
    Rails.logger.info "[ORDER ##{id}] 確認メールを送信(dummy)"
  end
end
