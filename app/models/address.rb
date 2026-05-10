class Address < ApplicationRecord
  belongs_to :user

  validates :postal_code, :prefecture, :city, :street, presence: true

  def decorate
    AddressDecorator.new(self)
  end
end
