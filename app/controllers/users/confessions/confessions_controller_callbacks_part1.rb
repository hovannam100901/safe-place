# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart1
      extend ActiveSupport::Concern
      include Users::Confessions::ConfessionsControllerCallbacksPart2
      include Users::Confessions::ConfessionsControllerCallbacksPart3

      included do
        before_action :set_confessions, only: %i[index destroy]
        # rubocop:enable Rails/LexicallyScopedActionFilter
        include Kaminari::PageScopeMethods

        private

        def set_confessions
          if params[:q]
            confessions_search_and_paging
          else
            @confessions = Confession
                           .eager_load(:rich_text_content, :user, :likes)
                           .order(created_at: :desc)
                           .page(params[:page]).per(3).load_async
          end
          set_paging_variable
        end

        def confessions_search_and_paging
          @confessions = Kaminari
                         .paginate_array(confessions_search)
                         .page(params[:page]).per(3)
        end

        def confessions_search
          @q = params[:q]
          (id_search + tag_search + user_search + content_search).uniq.sort_by(&:created_at).reverse
        end
      end
    end
  end
end
