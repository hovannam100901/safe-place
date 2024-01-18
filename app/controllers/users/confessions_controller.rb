# frozen_string_literal: true

module Users
  # class Confessions Controller
  class ConfessionsController < UsersLayoutController
    include Users::Confessions::ConfessionsControllerSimpleActions
    include Users::Confessions::ConfessionsControllerCreateAction
    include Users::Confessions::ConfessionsControllerUpdateAction
    include Users::Confessions::ConfessionsControllerDestroyAction
    include Users::Confessions::ConfessionsControllerServices
    include Users::Confessions::ConfessionsControllerCallbacksPart1
    include Users::Confessions::ConfessionsControllerCallbacksPart4
  end
end
