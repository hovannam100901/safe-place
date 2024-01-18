# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain services
    module ConfessionsControllerServices
      extend ActiveSupport::Concern

      included do
        def like
          LikeService.new(current_user, @confession).like
          respond_to do |format|
            format.turbo_stream do
              flash.now[:notice] = 'Confession liked/unliked successfully.'
            end
          end
        end
      end
    end
  end
end
