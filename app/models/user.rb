# frozen_string_literal: true

class User
  attr_reader :name, :age

  def initialize(name:, age:)
    @name = name
    @age = age
  end

  def adult?
    age >= 18
  end

  def greet
    "Hello, #{name}!"
  end
end
