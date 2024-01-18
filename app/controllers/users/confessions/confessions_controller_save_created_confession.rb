# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain private methods for create action
    module ConfessionsControllerSaveCreatedConfession
      extend ActiveSupport::Concern

      included do
        private

        def broadcast_created_confession
          Turbo::StreamsChannel
            .broadcast_prepend_later_to('confessions_index_channel',
                                        target: 'confessions',
                                        partial: 'users/confessions/confession_index',
                                        locals: { user: current_user, confession: @confession })
          Turbo::StreamsChannel
            .broadcast_prepend_later_to('not_signed_in_confessions_index_channel',
                                        target: 'confessions',
                                        partial: 'users/confessions/not_signed_in_confession_index',
                                        locals: { confession: @confession })
        end

        def handle_failed_create_confession
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
