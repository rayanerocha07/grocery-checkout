class Api::V1::OrderItemsController < ApplicationController
  before_action :set_order_item, only: [ :show, :update, :destroy ]

  def index
    @order_items = OrderItem.all
    render json: @order_items, status: :ok
  end

  def show
    render json: @order_item, status: :ok
  end

  def create
    @order_item = OrderItem.new(order_item_params)

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

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity, :unit_price, :order_id)
  end
end
