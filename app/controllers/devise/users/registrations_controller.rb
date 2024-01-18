# frozen_string_literal: true

module Devise
  module Users
    # Class RegistrationsController for Users
    class RegistrationsController < Devise::RegistrationsController
      layout 'blank_layout/user_blank'
      # before_action :configure_sign_up_params, only: [:create]
      # before_action :configure_account_update_params, only: [:update]

      # GET /resource/sign_up
      def new
        @user = User.new
        @user.build_user_info
      end

      # POST /resource
      def create
        user = User.new(user_params)
        return redirect_to new_user_registration_path, alert: user.errors.full_messages unless user.save

        redirect_to new_user_session_path
      end

      # GET /resource/edit
      # def edit
      #   super
      # end

      # PUT /resource
      # def update
      #   super
      # end

      def update
        respond_to do |format|
          if current_user.update_with_password(user_password_params)
            bypass_sign_in(current_user)
            format.turbo_stream { flash.now[:notice] = 'Password was successfully changed.' }
          else
            format.turbo_stream do
              flash.now[:alert] = helpers.sanitize(current_user.errors.full_messages.join('<br>'))
              render status: :bad_request
            end
          end
        end
      end

      def change_status
        current_user.update(anonymous: params[:anonymous])
        render json: { message: "The 'Anonymous' status has been successfully updated." }
      end

      # DELETE /resource
      # def destroy
      #   super
      # end

      # GET /resource/cancel
      # Forces the session data which is usually expired after sign
      # in to be expired now. This is useful if the user wants to
      # cancel oauth signing in/up in the middle of the process,
      # removing all OAuth session data.
      # def cancel
      #   super
      # end

      # protected

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_up_params
      #   devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, user_info_attributes: [:address, :date_of_birth, :profile_name, :gender]])
      # end

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_account_update_params
      #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
      # end

      # The path used after sign up.
      def after_sign_up_path_for(_resource)
        sign_out(_resource)
        new_user_session_path
      end

      def user_params
        params.require(:user).permit(:email, :password, :user_name,
                                     user_info_attributes: %i[address date_of_birth profile_name gender])
      end

      def user_password_params
        params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
      end
      # The path used after sign up for inactive accounts.
      # def after_inactive_sign_up_path_for(resource)
      #   super(resource)
      # end
    end
  end
end
