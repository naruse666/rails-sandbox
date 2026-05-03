FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyText" }
    price_cents { 1 }
    stock { 1 }
  end
end
