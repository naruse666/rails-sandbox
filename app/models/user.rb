# frozen_string_literal: true

class User < ApplicationRecord
  scope :adults, -> { where('age >= ?', 18) }

  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def adult?
    age >= 18
  end

  def greet
    "Hello, #{name}!"
  end
end
