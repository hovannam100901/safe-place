# frozen_string_literal: true

module Users
  module Confessions
    # class Comments Controller
    class CommentsController < Users::CommentsController
      private

      def set_commentable
        @commentable = Confession.find_by(id: params[:confession_id])
      end
    end
  end
end
