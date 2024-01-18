# frozen_string_literal: true

# class CreateEnrollments
class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.decimal :price, null: false, scale: 2, precision: 10
      t.references :user, null: false, foreign_key: true
      t.references :enrollmentable, polymorphic: true, null: false
      t.references :payment, null: false, foreign_key: true

      t.datetime :deleted_at

      t.timestamps
    end

    add_index :enrollments, :deleted_at
  end
end
