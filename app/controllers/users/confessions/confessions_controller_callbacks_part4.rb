# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart4
      extend ActiveSupport::Concern

      included do
        before_action :set_confession, only: %i[like show edit update destroy]
        before_action :authenticate_flash, only: %i[like update destroy]
        before_action :authenticate_user!, only: %i[create edit like update destroy]
        # rubocop:enable Rails/LexicallyScopedActionFilter

        private

        def set_confession
          @confession = Confession.find_by(id: params[:id])
          return unless @confession.nil?

          respond_to do |format|
            format.html { redirect_to root_path, alert: 'Confession not found.' }
            format.json { head :no_content }
          end
        end

        def confession_params
          params[:confession][:tag] = params[:confession][:tag].split(' ')
          params.require(:confession).permit({ tag: [] }, :content, :anonymous, :user_id)
        end

        def authenticate_flash
          return if user_signed_in?

          render turbo_stream: turbo_stream
            .replace('flash',
                     partial: 'shared/flash',
                     locals: { flash:
                       { 'alert' => 'Please sign in to continue' } })
        end
      end
    end
  end
end
