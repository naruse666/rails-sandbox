# frozen_string_literal: true

class UserRegistrationService
  def initialize(mailer: UserMailer)
    @mailer = mailer
  end

  def call(name:, age:)
    user = User.create!(name: name, age: age)
    @mailer.welcome_email(user).deliver_now
    user
  end
end
