# frozen_string_literal: true

require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @order = create(:order)
    @order_item = @order.order_items.first
  end

  def test_is_valid_with_factory
    assert @order_item.valid?
  end

  def test_is_invalid_without_product
    @order_item.product = nil
    assert_not @order_item.valid?
    assert_includes @order_item.errors[:product], "must exist"
  end

  def test_is_invalid_without_order
    @order_item.order = nil
    assert_not @order_item.valid?
    assert_includes @order_item.errors[:order], "must exist"
  end

  def test_item_total_calculates_correctly
    @order_item.quantity = 3

    expected_total = 3 * @order_item.product.price
    assert_equal expected_total, @order_item.item_total
  end

  def test_set_unit_price_callback_on_validation
    product = create(:product, price: 50.0)
    order_item = @order.order_items.new(product: product, quantity: 1)

    order_item.valid?

    assert_equal 50.0, order_item.unit_price
  end

  def test_update_order_total_price_after_save
    initial_product_price = @order_item.product.price
    @order_item.update!(quantity: 1)
    assert_equal initial_product_price, @order.reload.total_price

    @order_item.update!(quantity: 2)
    assert_equal initial_product_price * 2, @order.reload.total_price
  end

  def test_update_order_total_price_after_destroy
    product2 = create(:product, price: 10.0)
    item2 = create(:order_item, order: @order, product: product2, quantity: 1)

    order = @order.reload
    total_before_destroy = order.total_price

    item2.destroy

    total_after_destroy = order.reload.total_price

    assert_not_equal total_before_destroy, total_after_destroy
    assert_equal @order_item.item_total, total_after_destroy
  end
end
