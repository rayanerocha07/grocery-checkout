class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: 'pending'
      t.decimal :total_price, precision: 12, scale: 2, default: 0

      t.timestamps
    end
  end
end
