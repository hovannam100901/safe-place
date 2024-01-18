# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain private method for update action
    module ConfessionsControllerSaveUpdatedConfession2
      extend ActiveSupport::Concern

      included do
        private

        # for broadcast_updated_confession method
        def broadcast_updated_confession_card_tag
          Turbo::StreamsChannel
            .broadcast_update_later_to('confessions_index_channel',
                                       target: "#{helpers.dom_id(@confession)}_card_tag",
                                       partial: 'users/confessions/confession_card_tag',
                                       locals: { confession: @confession })
        end

        # for broadcast_updated_confession method
        def broadcast_updated_confession_card_tag_not_signed_in
          Turbo::StreamsChannel
            .broadcast_update_later_to('not_signed_in_confessions_index_channel',
                                       target: "#{helpers.dom_id(@confession)}_card_tag",
                                       partial: 'users/confessions/confession_card_tag',
                                       locals: { confession: @confession })
        end

        # for broadcast_updated_confession method
        def broadcast_updated_confession_show
          Turbo::StreamsChannel
            .broadcast_update_later_to('confessions_show_channel',
                                       target: "#{helpers.dom_id(@confession)}_show",
                                       partial: 'users/confessions/confession',
                                       locals: { confession: @confession })
        end
      end
    end
  end
end
