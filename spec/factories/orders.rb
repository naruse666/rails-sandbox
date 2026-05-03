FactoryBot.define do
  factory :order do
    user { nil }
    address { nil }
    status { "MyString" }
    total_cents { 1 }
  end
end
