# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    association :product
    association :order
    quantity { 2 }
    unit_price { 9.99 }
  end
end
