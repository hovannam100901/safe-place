# frozen_string_literal: true

module Users
  # class counselors
  class CounselorsController < UsersBlankLayoutController
    before_action :authenticate_user!
    def index
      if current_user.type == 'User'
        @q = Counselor.ransack(params[:q])
        @counselors = @q.result(distinct: true).order(id: :desc).page(params[:page]).per(5)
      else
        @q = Room.where(counselor_id: current_user.id, status: 'enable').includes(:user).ransack(params[:q])
        @rooms = @q.result.order(id: :desc).page(params[:page]).per(5)
      end
    end
  end
end
