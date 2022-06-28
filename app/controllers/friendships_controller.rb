# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(id: params[:friend_id])
    friendship = current_user.friendships.build(friend_id: friend.id)
    if friendship.save!
      flash[:notice] = "You´re following to #{friend.full_name}"
      redirect_to my_friends_path
    end  
  end

  def destroy
    friend = User.find_by(id: params[:id])
    friendship = current_user.friendships.load.where(friend_id: friend.id).first
    if friendship.destroy
      flash[:notice] = "#{friend.full_name} is not followed by you anymore" 
      redirect_to my_friends_path
    end
  end  
end
