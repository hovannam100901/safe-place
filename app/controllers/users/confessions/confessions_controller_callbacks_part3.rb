# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart3
      extend ActiveSupport::Concern

      included do
        private

        # for set_confessions method
        def set_paging_variable
          @current_page = @confessions.current_page
          @total_pages = @confessions.total_pages
          @has_next_page = @current_page < @total_pages
        end
      end
    end
  end
end
