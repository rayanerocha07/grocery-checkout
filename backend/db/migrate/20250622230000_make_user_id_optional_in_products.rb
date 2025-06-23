# frozen_string_literal: true

class MakeUserIdOptionalInProducts < ActiveRecord::Migration[8.0]
  def change
    change_column_null :products, :user_id, true
  end
end
