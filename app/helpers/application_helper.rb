# frozen_string_literal: true

# module Application Helper
module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.replace 'flash' do
      render partial: 'shared/flash'
    end
  end
end
