class Checkout
  include ActiveModel::Model

  attr_accessor :user, :postal_code, :prefecture, :city, :street
  attr_reader :order

  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :street, presence: true

  def save
    return false unless valid?

    address = user.address || user.build_address
    address.assign_attributes(
      postal_code: postal_code,
      prefecture: prefecture,
      city: city,
      street: street
    )

    Address.transaction do
      address.save!
      result = PlaceOrderService.call(user: user, address: address)
      if result.success?
        @order = result.value
      else
        errors.add(:base, result.error)
        raise ActiveRecord::Rollback
      end
    end

    errors.empty?
  rescue StandardError => e
    errors.add(:base, "予期せぬエラーが発生しました: #{e.message}") if errors.empty?
    false
  end
end
