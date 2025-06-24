# frozen_string_literal: true

require "test_helper"

class Api::V1::OrderItemsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  def setup
    @order = create(:order)
    @order_item = @order.order_items.first
  end

  def test_should_get_index
    get api_v1_order_items_url, as: :json
    assert_response :success
  end

  def test_should_show_order_item
    get api_v1_order_item_url(@order_item), as: :json
    assert_response :success
  end

  def test_should_create_order_item
    new_product = create(:product)
    order_item_params = {
      order_item: { product_id: new_product.id, quantity: 3 }
    }

    assert_difference("@order.order_items.count", 1) do
      post api_v1_order_order_items_url(@order), params: order_item_params, as: :json
    end

    assert_response :created
  end

  def test_should_update_order_item
    new_quantity = @order_item.quantity + 5

    patch api_v1_order_order_item_url(@order, @order_item), params: { order_item: { quantity: new_quantity } }, as: :json

    assert_response :success
    @order_item.reload
    assert_equal new_quantity, @order_item.quantity
  end

  def test_should_destroy_order_item
    create(:order_item, order: @order)

    assert_difference("OrderItem.count", -1) do
      delete api_v1_order_order_item_url(@order, @order_item), as: :json
    end

    assert_response :no_content
  end
end
