# frozen_string_literal: true

module Admins
  # class RoomsController
  class RoomsController < AdminsLayoutController
    def index
      @q = Room.includes(:user).ransack(params[:q])
      @rooms = @q.result.order(id: :desc).page params[:page]
    end

    def show; end

    def new
      @room = Room.new
      render layout: false
    end

    def edit
      @room = Room.find(params[:id])
      # render layout: false
    end

    def create
      @room = Room.new(room_params)
      @room.status = 'disable'
      respond_to do |format|
        if @room.save
          format.turbo_stream { flash.now[:notice] = 'Room created.' }
        else
          format.turbo_stream do
             flash.now[:alert] = 'Room not created.'
             render status: :bad_request
          end
        end
      end
    end

    def change_status
      @room = Room.find(params[:id])
      if @room.status.nil? || (@room.status == 'disable')
        @room.update(status: 'enable')
      else
        @room.update(status: 'disable')
      end
      respond_to do |format|
        format.js
      end
    end

    def update
      @room = Room.find(params[:id])

      if @room.update(room_params)
        flash.now[:notice] = 'Room was successfully updated.'
        respond_to do |format|
          format.turbo_stream
        end
      else
        flash.now[:alert] = @room.errors.full_messages.join(', ')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @room = Room.find(params[:id])
      @room.destroy
      respond_to do |format|
        format.html { redirect_to admins_rooms_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def room_params
      params.require(:room).permit(:id, :name, :user_id, :counselor_id)
    end
  end
end
