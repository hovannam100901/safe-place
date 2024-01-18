# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart2
      extend ActiveSupport::Concern

      included do
        private

        # for set_confessions method
        def id_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .ransack(id_eq: @q).result.load_async
        end

        # for set_confessions method
        def tag_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .ransack(tags_cont: @q).result.load_async
        end

        # for set_confessions method
        def user_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .where(anonymous: false)
            .ransack(user_user_name_cont: @q).result.load_async
        end

        # for set_confessions method
        def content_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .where('action_text_rich_texts.body LIKE ?', "%#{@q}%").load_async
        end
      end
    end
  end
end
