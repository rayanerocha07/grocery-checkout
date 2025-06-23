# frozen_string_literal: true

require "test_helper"

class Api::V1::OrderItemsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  def setup
    @order_item = create(:order_item)
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
    order = create(:order)
    product = create(:product)

    assert_difference("OrderItem.count") do
      post api_v1_order_items_url, params: {
        order_item: {
          product_id: product.id,
          quantity: 3,
          unit_price: 15.0,
          order_id: order.id
        }
      }, as: :json
    end

    assert_response :created
  end

  def test_should_destroy_order_item
    assert_difference("OrderItem.count", -1) do
      delete api_v1_order_item_url(@order_item), as: :json
    end

    assert_response :no_content
  end
end
