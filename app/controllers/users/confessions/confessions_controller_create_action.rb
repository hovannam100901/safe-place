# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain create action
    module ConfessionsControllerCreateAction
      extend ActiveSupport::Concern
      include Users::Confessions::ConfessionsControllerSaveCreatedConfession

      included do
        def create
          @confession = Confession.new(confession_params)
          @confession.user_id = current_user.id
          save_created_confession
        end

        private

        def save_created_confession
          if @confession.save
            respond_to do |format|
              format.turbo_stream { flash.now[:notice] = 'Confession was successfully created.' }
              format.json { render :show, status: :created, location: @confession }
            end
            broadcast_created_confession
          else
            handle_failed_create_confession
          end
        end
      end
    end
  end
end
