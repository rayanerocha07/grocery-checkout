class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  before_save :set_unit_price

  private

  def set_unit_price
    self.unit_price = product.price if product.present?
  end
end
