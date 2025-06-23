require "test_helper"

class ProductTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @product = build(:product)
  end

  def test_valid_product
    assert @product.valid?
  end

  def test_invalid_without_name
    @product.name = nil
    assert_not @product.valid?
    assert_includes @product.errors[:name], "can't be blank"
  end

  def test_invalid_without_price
    @product.price = nil
    assert_not @product.valid?
    assert_includes @product.errors[:price], "is not a number"
  end

  def test_invalid_with_negative_price
    @product.price = -1.0
    assert_not @product.valid?
    assert_includes @product.errors[:price], "must be greater than 0"
  end

  def test_invalid_with_zero_price
    @product.price = 0.0
    assert_not @product.valid?
    assert_includes @product.errors[:price], "must be greater than 0"
  end
end
