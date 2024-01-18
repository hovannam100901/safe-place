# frozen_string_literal: true

module Users
  # class UsersPagesController
  class ConversationsController < UsersLayoutController
    def create
      @room = Room.find(params[:room_id])
      @conversation = current_user.conversations.new(room_id: @room.id, content: params[:conversation][:content])
      if @conversation.save
        Turbo::StreamsChannel.broadcast_append_to "room_#{@room.id}",
                                                  partial: 'users/conversations/partials/conversation',
                                                  locals: { conversation: @conversation },
                                                  target: 'conversations'
        Turbo::StreamsChannel.broadcast_append_to [@conversation.conversationable&.to_gid_param],
                                                  target: "controls_conversation_#{@conversation.id}",
                                                  partial: 'users/conversations/partials/display_controls',
                                                  locals: { conversation: @conversation, user: current_user }
        respond_to do |format|
          format.turbo_stream 
        end
      else
        respond_to do |format|
          format.turbo_stream { flash.now[:alert] = helpers.sanitize(@conversation.errors.full_messages.join('<br>')) }
        end
      end
    end

    def destroy
      @room = Room.find(params[:room_id])
      @conversation = @room.conversations.find(params[:id])
      respond_to do |format|
        if current_user == @conversation.conversationable
          if @conversation.destroy
            Turbo::StreamsChannel.broadcast_remove_to("room_#{@room.id}", target: "conversation_#{@conversation.id}")
            format.turbo_stream { flash.now[:notice] = 'Successfully removed' }
          end
        else
          format.turbo_stream { flash.now[:alert] = 'Error! Something went wrong' }
        end
      end
    end
  end
end
