# frozen_string_literal: true

module Users
  # A service class for handling bookmarks
  class BookmarkService < ApplicationService
    def initialize(user, bookmarkable)
      @user = user
      @bookmarkable = bookmarkable
      super()
    end

    def call
      exists? ? destroy : create
    end

    def create
      @user.bookmarks.create(bookmarkable: @bookmarkable, anonymous: @user.anonymous)
    end

    def destroy
      bookmark = @user.bookmarks.find_by(bookmarkable: @bookmarkable)
      bookmark&.destroy
    end

    def exists?
      @user.bookmarks.exists?(bookmarkable: @bookmarkable)
    end
  end
end
