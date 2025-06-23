# frozen_string_literal: true

class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :quantity, :unit_price, :item_total

  def item_total
    object.unit_price * object.quantity
  end
end
