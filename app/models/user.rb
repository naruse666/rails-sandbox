# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def adult?
    age >= 18
  end

  def greet
    "Hello, #{name}!"
  end
end
