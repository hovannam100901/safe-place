# frozen_string_literal: true

# class CreateCourseSessions
class CreateCourseSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :course_sessions do |t|
      t.string :name, null: false
      t.string :image
      t.string :video, null: false
      t.integer :session_number
      t.string :description
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
