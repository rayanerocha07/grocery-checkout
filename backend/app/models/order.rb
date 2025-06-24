# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy, inverse_of: :order

  accepts_nested_attributes_for :order_items

  validates :total_price, numericality: { greater_than: 0 }
  validates :status, presence: true
  validate :must_have_order_items

  enum :status, {
    pending: 0,
    completed: 1,
    cancelled: 2
  }, default: :pending, suffix: true

  def calculate_total_price
    self.total_price = order_items.reject(&:marked_for_destruction?).sum(&:item_total)
  end

  before_validation :calculate_total_price

  private
  def must_have_order_items
    errors.add(:order_items, "must exist") if order_items.empty?
  end
end
