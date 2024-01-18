# frozen_string_literal: true

module Users
  # class PagesController
  class PagesController < ApplicationController
    layout 'users_layout/users'

    def home
      @confession_url ||= session[:confession_url]
      @home ||= session[:main_url]
    end

    def contact; end
    def about_app; end
    def term; end
    def about_us; end
    def support; end
    def mobile_app; end
  end
end
