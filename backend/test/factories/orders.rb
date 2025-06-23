# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total_price { 100.0 }
    status { "pending" }
  end
end
