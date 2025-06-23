# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 500 }
end
