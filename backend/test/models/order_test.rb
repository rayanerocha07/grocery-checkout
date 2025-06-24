# frozen_string_literal: true

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def test_is_valid_with_default_factory_attributes
    order = build(:order)
    assert order.valid?
  end

  def test_is_invalid_without_a_status
    order = build(:order, status: nil)
    assert_not order.valid?
    assert_includes order.errors[:status], "can't be blank"
  end

  def test_is_invalid_without_order_items
    order = build(:order)
    order.order_items.clear

    assert_not order.valid?
    assert_includes order.errors[:order_items], "must exist"
    assert_includes order.errors[:total_price], "must be greater than 0"
  end

  def test_calculates_total_price_correctly_before_saving
    product1 = create(:product, price: 10.00)
    product2 = create(:product, price: 5.50)

    order = build(:order)
    order.order_items.clear

    order.order_items.build(product: product1, quantity: 2)
    order.order_items.build(product: product2, quantity: 3)

    order.save!

    expected_total = 36.50
    assert_in_delta expected_total, order.total_price, 0.01
  end
end
