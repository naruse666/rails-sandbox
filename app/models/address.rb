class Address < ApplicationRecord
  belongs_to :user

  validates :postal_code, :prefecture, :city, :street, presence: true

  def full_address
    "#{postal_code} #{prefecture}#{city}#{street}"
  end
end
