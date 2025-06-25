# frozen_string_literal: true

require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  def setup
    @user = create(:user)
    @product = create(:product, user: @user)
    @auth_headers = {
      "Authorization" => "Bearer #{JsonWebToken.encode(user_id: @user.id)}"
    }
  end

  def test_should_get_index
    get api_v1_products_url, headers: @auth_headers, as: :json
    assert_response :success
  end

  def test_should_show_product
    get api_v1_product_url(@product), headers: @auth_headers, as: :json
    assert_response :success
  end

  def test_should_create_product
    assert_difference("Product.count") do
      post api_v1_products_url, headers: @auth_headers, params: { product: { user_id: @product.user_id, name: @product.name, price: @product.price, description: @product.description } }, as: :json
    end

    assert_response :created
  end

  def test_should_update_product
    patch api_v1_product_url(@product), headers: @auth_headers, params: { product: { user_id: @product.user_id, name: @product.name, price: @product.price, description: @product.description } }, as: :json
    assert_response :success
  end

  def test_should_destroy_product
    assert_difference("Product.count", -1) do
      delete api_v1_product_url(@product), headers: @auth_headers, as: :json
    end

    assert_response :no_content
  end
end
