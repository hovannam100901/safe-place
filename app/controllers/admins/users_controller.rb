# frozen_string_literal: true

module Admins
  # Class UsersController for Admins
  class UsersController < AdminsLayoutController
    before_action :set_user, only: %i[show edit update destroy]

    DEFAULT_PASSWORD = '123456'

    def index
      @q = User.where(type: :User).includes(:user_info).ransack(params[:q])
      @users = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def show
      render layout: false
    end

    def new
      @user = User.new
      @user.user_info = UserInfo.new
      render layout: false
    end

    def edit
      render layout: false
    end

    def create
      @user = User.new(user_params)
      @user.password = DEFAULT_PASSWORD

      respond_to do |format|
        if @user.save
          format.turbo_stream { flash.now[:notice] = "#{@user.type} was successfully created!" }
        else
          format.turbo_stream { render status: :bad_request }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(update_user_params)
          format.turbo_stream { flash.now[:notice] = "#{@user.type} was successfully created!" }
        else
          format.turbo_stream do
            render status: :bad_request
          end
        end
      end
    end

    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admins_users_url(page: params[:page]), notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def toggle_anonymous
      @user = User.find_by(id: params[:id])
      @user.update(anonymous: params[:anonymous])
      render json: { message: "The 'Anonymous' status has been successfully updated." }
    end

    private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def update_user_params
      params.require(:user).permit(:anonymous, :password, :phone_number, :status, :type, :user_name,
                                   user_info_attributes: %i[id address date_of_birth gender profile_name])
    end

    def user_params
      params.require(:user).permit(:email, :anonymous, :password, :phone_number, :status, :type, :user_name,
                                   user_info_attributes: %i[address date_of_birth gender profile_name])
    end
  end
end
