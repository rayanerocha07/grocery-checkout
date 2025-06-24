# frozen_string_literal: true

class Api::V1::OrderItemsController < ApplicationController
  before_action :set_order, only: [ :create, :update, :destroy ]
  before_action :set_order_item, only: [ :update, :destroy ]
  before_action :set_standalone_order_item, only: [ :show ]

  def index
    @order_items = OrderItem.all
    render json: @order_items, status: :ok
  end

  def show
    render json: @order_item, status: :ok
  end

  def create
    @order_item = @order.order_items.new(order_item_params)

    if @order_item.save
      render json: @order_item, status: :created
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order_item.update(order_item_params)
      render json: @order_item, status: :ok
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_order_item
    @order_item = @order.order_items.find(params[:id])
  end

  def set_standalone_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
