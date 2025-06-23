# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status, :total_price, :created_at, :updated_at

  has_many :order_items
end
