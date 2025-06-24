# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    product
    quantity { Faker::Number.between(from: 1, to: 5) }
  end
end
