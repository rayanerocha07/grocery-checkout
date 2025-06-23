class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  before_save :set_unit_price
  after_save :update_order_total_price
  after_destroy :update_order_total_price if :order

  def item_total
    unit_price * quantity
  end

  private

  def set_unit_price
    self.unit_price = product.price if product
  end

  def update_order_total_price
    order.calculate_total_price
    order.save
  end
end
