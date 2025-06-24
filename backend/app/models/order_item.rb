# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order, inverse_of: :order_items
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than: 0 }

  before_validation :set_unit_price

  after_save :update_order_total_price
  after_destroy :update_order_total_price

  def item_total
    price = unit_price || product&.price || 0
    price * quantity
  end

  private

  def set_unit_price
    if self.product.present?
    end
    self.unit_price ||= product.price if product
  end

  def update_order_total_price
    order.calculate_total_price
    order.save
  end
end
