# frozen_string_literal: true

# class CreatePayments
class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false, scale: 2, precision: 10
      t.boolean :status, default: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :payments, :deleted_at
  end
end
