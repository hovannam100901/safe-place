# frozen_string_literal: true

module Users
    # class Comments Controller
    class BookmarksController < UsersLayoutController
        def index
            @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(6)
        end
    end
end