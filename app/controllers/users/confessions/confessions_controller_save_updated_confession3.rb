# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain private method for update action
    module ConfessionsControllerSaveUpdatedConfession3
      extend ActiveSupport::Concern

      included do
        private

        def handle_failed_update_confession
          respond_to do |format|
            format.turbo_stream do
              flash.now[:alert] =
                helpers.sanitize("<ul><li>#{@confession.errors.full_messages.join('</li><li>')}</li><ul>")
              render status: :unprocessable_entity
            end
            format.json { render json: @confession.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end
