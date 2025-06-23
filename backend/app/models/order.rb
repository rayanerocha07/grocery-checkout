# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  enum :status, {
    pending: 0,
    completed: 1,
    cancelled: 2
  }, default: :pending, suffix: true

  def calculate_total_price
    self.total_price = order_items.sum { |item| item.unit_price * item.quantity }
  end

  before_save :calculate_total_price
end
