# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain update action
    module ConfessionsControllerUpdateAction
      extend ActiveSupport::Concern
      include Users::Confessions::ConfessionsControllerSaveUpdatedConfession1
      include Users::Confessions::ConfessionsControllerSaveUpdatedConfession3

      included do
        def update
          if @confession.update(confession_params)
            respond_to do |format|
              format.turbo_stream { flash.now[:notice] = 'Confession was successfully updated.' }
              format.json { render :show, status: :ok, location: @confession }
            end
            broadcast_updated_confession
          else
            handle_failed_update_confession
          end
        end
      end
    end
  end
end
