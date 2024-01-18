# frozen_string_literal: true

# A module for formatting time durations.
module TimeFormattingHelper
  def formatted_duration(duration)
    return '0' if duration.nil? || duration.zero?

    hours = duration / 3600
    minutes = (duration % 3600) / 60
    seconds = duration % 60

    formatted_time = build_formatted_time(hours, minutes, seconds)

    formatted_time.join
  end

  private

  def build_formatted_time(hours, minutes, seconds)
    formatted_time = []

    if hours.positive?
      formatted_time << "#{hours}h"
      formatted_time << "#{minutes}m" if minutes.positive?
    elsif minutes.positive?
      formatted_time << "#{minutes}m"
      formatted_time << "#{seconds}s" if seconds.positive?
    elsif seconds.positive?
      formatted_time << "#{seconds}s"
    end

    formatted_time
  end
end
