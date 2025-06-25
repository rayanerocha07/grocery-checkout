# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
end
