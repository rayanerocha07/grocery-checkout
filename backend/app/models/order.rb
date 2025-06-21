class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :status, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  enum status: { pending: 0, completed: 1, cancelled: 2 }

  def calculate_total_price
    self.total_price = order_items.sum('price * quantity')
  end

  before_save :calculate_total_price
end
