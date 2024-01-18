# frozen_string_literal: true

# Add duration column to podcasts
class AddDurationToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :duration, :decimal
  end
end
