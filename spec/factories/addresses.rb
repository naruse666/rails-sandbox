FactoryBot.define do
  factory :address do
    user { nil }
    postal_code { "MyString" }
    prefecture { "MyString" }
    city { "MyString" }
    street { "MyString" }
  end
end
