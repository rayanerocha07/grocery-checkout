class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  enum :status, {
    pending: 0,
    completed: 1,
    cancelled: 2
  }, default: :pending, suffix: true

  def calculate_total_price
    total = order_items.sum("COALESCE(unit_price, 0) * COALESCE(quantity, 0)")
    self.total_price = total || 0
  end

  before_save :calculate_total_price
end
