# frozen_string_literal: true

module Users
  # Class Media Player Controller
  class MediaPlayersController < UsersLayoutController
    def index
      render layout: false
    end
  end
end
