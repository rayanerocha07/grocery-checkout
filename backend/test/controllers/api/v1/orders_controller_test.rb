# frozen_string_literal: true

require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

def setup
  @user = create(:user)
  @order = create(:order, user: @user)
  @auth_headers = {
    "Authorization" => "Bearer #{JsonWebToken.encode(user_id: @user.id)}"
  }
end

  def test_should_get_index
    get api_v1_orders_url, headers: @auth_headers, as: :json
    assert_response :success
  end

  def test_should_show_order
    get api_v1_order_url(@order), headers: @auth_headers, as: :json
    assert_response :success
  end

  def test_should_create_order
    product = create(:product)

    valid_order_params = {
      order: {
        order_items_attributes: [
          {
            product_id: product.id,
            quantity: 2
          }
        ]
      }
    }

    assert_difference([ "Order.count", "OrderItem.count" ], 1) do
      post api_v1_orders_url, headers: @auth_headers, params: valid_order_params, as: :json
    end

    assert_response :created
  end

  def test_should_update_order
    patch api_v1_order_url(@order), headers: @auth_headers, params: { order: { user_id: @order.user_id, status: @order.status } }, as: :json
    assert_response :success
  end

  def test_should_destroy_order
    assert_difference("Order.count", -1) do
      delete api_v1_order_url(@order), headers: @auth_headers, as: :json
    end

    assert_response :no_content
  end
end
