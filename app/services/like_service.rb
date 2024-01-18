# frozen_string_literal: true

# app/services/like_service.rb
class LikeService
  def initialize(user, item)
    @user = user
    @item = item
  end

  def like
    if already_liked?
      unlike
    else
      create_like
    end
  end

  private

  def already_liked?
    @user.likes.exists?(likeable: @item)
  end

  def unlike
    like = @user.likes.find_by(likeable: @item)
    like.destroy
  end

  def create_like
    @user.likes.create(likeable: @item)
  end
end
