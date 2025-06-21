class Product < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 500 }
end
