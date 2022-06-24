# frozen_string_literal: true

class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    @friends = User.results(params[:friend])
    if @friends
      respond_to do |format|
        format.js { render partial: 'users/results.js' }
      end
    else
      flash.now[:alert] = "Please input a valid user email or name"
      respond_to do |format|
        format.js { render partial: 'users/results.js' }
      end
    end
  end
end
