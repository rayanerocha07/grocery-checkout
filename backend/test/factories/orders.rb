# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    status { :pending }

    after(:build) do |order|
      if order.order_items.empty?
        order.order_items << build(:order_item, order: order)
      end
    end

    trait :with_multiple_items do
      transient do
        items_count { 3 }
      end

      after(:build) do |order, evaluator|
        order.order_items.clear
        order.order_items = build_list(:order_item, evaluator.items_count, order: order)
      end
    end
  end
end
