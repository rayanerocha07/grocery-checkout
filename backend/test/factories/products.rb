# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 1.0..1000.0) }
  end
end
