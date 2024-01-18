# frozen_string_literal: true

require 'streamio-ffmpeg'

module MediaManager
  # A service class for find duration of media
  class DurationService < ApplicationService
    def initialize(file)
      @file = file
      super()
    end

    def call
      begin
        media = FFMPEG::Movie.new(@file.path)
        media.duration
      end
    rescue FFMPEG::Error => e
      Rails.logger.debug "Error: #{e.message}"
    end
  end
end
