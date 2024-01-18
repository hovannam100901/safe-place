# frozen_string_literal: true

# Class AdminsLayoutController
class AdminsLayoutController < ApplicationController
  layout 'admins_layout/admins'
  before_action :authenticate_admin!
end
