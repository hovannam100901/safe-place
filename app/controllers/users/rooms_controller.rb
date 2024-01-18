# frozen_string_literal: true

module Users
  # class UsersPagesController
  class RoomsController < UsersBlankLayoutController
    before_action :authenticate_user!

    def show
      if current_user.type == 'User'
        join_counselor_room
      else
        @room = Room.where(status: 'enable').find_by(id: params[:id], counselor_id: current_user.id)
      end
    end

    def join_counselor_room
      counselor_id = params[:id]
      rooms = Room.where(counselor_id: counselor_id, status: 'enable')
      room_joined = rooms.find_by(user_id: current_user.id)
  
      if room_joined
        @room = room_joined
      elsif rooms.where(user_id: nil).exists?
        room_to_join = rooms.where(user_id: nil).first
        room_to_join.update(user_id: current_user.id)
        @room = room_to_join
      else
        new_room = Room.create(user_id: current_user.id, name: "room#{current_user.id}", counselor_id: counselor_id, status: 'enable')
        @room = new_room
      end
    end

    private

    def room_params
      params.require(:room).permit(:name, :user_id, :counselor_id)
    end
  end
end
