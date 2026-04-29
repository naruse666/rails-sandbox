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

  def greeting_message
    hour = Time.current.hour
    if hour < 12
      "#{name}, おはよう"
    elsif hour < 18
      "#{name}, こんにちは"
    else
      "#{name}, こんばんは"
    end
  end
end
