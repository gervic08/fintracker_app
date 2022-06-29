# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    unless current_user
      redirect_to '/users/sign_in'
    end
  end
end
