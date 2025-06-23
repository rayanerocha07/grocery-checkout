# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { "Produto Teste" }
    price { 10.0 }
  end
end
