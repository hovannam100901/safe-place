# frozen_string_literal: true

# class CreateCourses
class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :instructor_name, null: false
      t.string :image
      t.string :description
      t.decimal :price, scale: 2, precision: 10, null: false
      t.references :admin, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :courses, :deleted_at
  end
end
