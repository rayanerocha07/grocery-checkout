require "test_helper"

class OrderTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @order = build(:order)
    @product = create(:product)
    @order.order_items << build(:order_item, product: @product, order: @order)
    @order.save!
  end


  def test_valid_order
    assert @order.valid?
  end

  def test_invalid_without_status
    @order.status = nil
    assert_not @order.valid?
    assert_includes @order.errors[:status], "can't be blank"
  end

  def test_invalid_without_total_price
    @order.total_price = nil
    assert_not @order.valid?
    assert_includes @order.errors[:total_price], "is not a number"
  end

  def test_invalid_with_negative_total_price
    @order.total_price = -1.0
    assert_not @order.valid?
    assert_includes @order.errors[:total_price], "must be greater than 0"
  end

  def test_invalid_with_zero_total_price
    @order.total_price = 0.0
    assert_not @order.valid?
    assert_includes @order.errors[:total_price], "must be greater than 0"
  end

  def test_invalid_without_order_items
    @order.order_items.destroy_all
    assert_not @order.valid?
    assert_includes @order.errors[:order_items], "must exist"
  end
end
