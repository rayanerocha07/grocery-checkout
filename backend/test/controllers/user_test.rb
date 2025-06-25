# frozen_string_literal: true

require "test_helper"

class UserTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  def setup
    @user = build(:user)
  end

  def test_should_register_user
    post "/register", params: {
      user: {
        email: @user.email,
        password: @user.password,
        password_confirmation: @user.password
      }
    }
    assert_response :success
  end

  def test_should_authenticate_user
    created_user = create(:user, password: "123456", password_confirmation: "123456")
    post "/login", params: { email: created_user.email, password: "123456" }
    assert_response :success
  end

  def test_invalid_login
    post "/login", params: { email: @user.email, password: "123456" }
    assert_response :unauthorized
  end

  def test_invalid_password
    created_user = create(:user, password: "123456", password_confirmation: "123456")
    post "/login", params: { email: created_user.email, password: "1234567" }
    assert_response :unauthorized
  end
end
