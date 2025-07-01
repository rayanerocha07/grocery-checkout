# frozen_string_literal: true

OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all

users = User.create!([
  { email: "alice@example.com", password: "password", password_confirmation: "password" },
  { email: "bob@example.com", password: "password", password_confirmation: "password" }
])

products = Product.create!([
  { name: "Produto A", price: 10.0 },
  { name: "Produto B", price: 20.0 },
  { name: "Produto C", price: 50.0 }
])

orders = Order.create!([
  {
    user: users.first,
    status: :pending,
    order_items_attributes: [
      { product: products[0], quantity: 2 },
      { product: products[1], quantity: 1 }
    ]
  },
  {
    user: users.last,
    status: :completed,
    order_items_attributes: [
      { product: products[2], quantity: 3 },
      { product: products[0], quantity: 5 }
    ]
  },
  {
    user: nil,
    status: :pending,
    order_items_attributes: [
      { product: products[1], quantity: 4 }
    ]
  }
])

puts "Seeds created!"
