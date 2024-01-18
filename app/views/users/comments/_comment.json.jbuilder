# frozen_string_literal: true

json.extract! comment, :id, :comment, :anonymous, :user_id, :commentable_type, :commentable_id, :created_at, :updated_at
json.url send("users_#{commentable.class.to_s.underscore}_comments_path", commentable, comment, format: :json)
