# frozen_string_literal: true

# class CreateSessionStates
class CreateSessionStates < ActiveRecord::Migration[7.0]
  def change
    create_table :session_states do |t|
      t.boolean :complete, default: false
      t.references :course_session, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
