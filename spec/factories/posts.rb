# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'テスト投稿' }
    body { '本文です' }
    association :user
  end
end
