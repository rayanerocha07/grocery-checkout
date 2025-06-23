require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @order_item = create(:order_item)
  end

  def test_valid_order_item
    assert @order_item.valid?
  end

  def test_invalid_without_product
    @order_item.product = nil
    assert_not @order_item.valid?
    assert_includes @order_item.errors[:product], "must exist"
  end

  def test_invalid_without_order
    @order_item.order = nil
    assert_not @order_item.valid?
    assert_includes @order_item.errors[:order], "must exist"
  end

  def test_invalid_without_quantity
    @order_item.quantity = nil
    assert_not @order_item.valid?
    assert_includes @order_item.errors[:quantity], "is not a number"
  end

  def test_invalid_without_unit_price
    @order_item.unit_price = nil
    assert_not @order_item.valid?
    assert_includes @order_item.errors[:unit_price], "is not a number"
  end

  def test_calculate_total_price
    @order_item.quantity = 3
    @order_item.unit_price = 10.0
    assert_equal 30.0, @order_item.item_total
  end

  def test_set_unit_price_before_save
    product = create(:product, price: 20.0)
    @order_item.product = product
    @order_item.save
    assert_equal 20.0, @order_item.unit_price
  end

  def test_update_order_total_price_after_save
    @order_item.update(quantity: 2, unit_price: 10.0)
    @order_item.order.reload
    assert_equal 20.0, @order_item.order.total_price
  end

  def test_update_order_total_price_after_destroy
    order = @order_item.order
    initial_total = order.total_price
    @order_item.destroy
    assert_not_equal initial_total, order.reload.total_price
  end
end
