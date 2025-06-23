# frozen_string_literal: true

class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [ :show, :update, :destroy ]

  def index
    @orders = Order.includes(:order_items).order(created_at: :desc).all

    render json: @orders, status: :ok
  end

  def show
    render json: @order, status: :ok
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :status, order_items_attributes: [ :product_id, :quantity, :unit_price ])
  end
end
