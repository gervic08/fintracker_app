# frozen_string_literal: true

class UserStocksController < ApplicationController
  before_action :set_stock

  def create
    stock ||= Stock.lookup(params[:ticker])
    stock.save! unless stock.persisted?
    @user_stock = UserStock.create(user: current_user, stock: stock)
    if @user_stock.save!
      flash[:notice] = "Stock #{stock.name} successfully added to portfolio"
      redirect_to my_portfolio_path
    end  
  end

  private

  def set_stock
    stock = Stock.find_by(ticker: params[:ticker])
  end
end
