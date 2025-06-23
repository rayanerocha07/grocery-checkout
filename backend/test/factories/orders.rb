# frozen_string_literal: true

# test/factories/orders.rb
FactoryBot.define do
  factory :order do
    total_price { 100.0 }
    status { "pending" }
  end
end
