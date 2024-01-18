# frozen_string_literal: true

json.array! @confessions, partial: 'users/confessions/confession', as: :confession
