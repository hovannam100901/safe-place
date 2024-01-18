# frozen_string_literal: true

# class UsersLayoutController
class UsersLayoutController < ApplicationController
  layout 'users_layout/users'
  before_action :check_current_url

  private

  def check_current_url
    conditions.each do |condition|
      if condition[:keywords].any? { |keyword| current_url.include?(keyword) } && request.referer.nil?
        redirect_to_root_and_store_session(condition[:session_key])
      elsif session[condition[:session_key]]
        clear_session(condition[:session_key])
      end
    end
  end

  def current_url
    request.original_url
  end

  def conditions
    [
      { keywords: ['confession'], session_key: :confession_url },
      { keywords: %w[album podcast counselor], session_key: :main_url }
    ]
  end

  def redirect_to_root_and_store_session(session_key)
    redirect_to root_path
    session[session_key] = current_url
  end

  def clear_session(session_key)
    session[session_key] = nil
  end
end
