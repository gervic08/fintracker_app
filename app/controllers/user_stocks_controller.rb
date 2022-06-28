# frozen_string_literal: true

class UserStocksController < ApplicationController
  
  def create
    stock ||= Stock.lookup(params[:ticker])
    stock.save! unless stock.persisted?
    user_stock = current_user.user_stocks.build(stock_id: stock.id)
    if user_stock.save!
      flash[:notice] = "Stock #{stock.name} successfully added to portfolio"
      redirect_to my_portfolio_path
    end  
  end

  def destroy
    stock = Stock.find_by(id: params[:id])
    user_stock = current_user.user_stocks.load.where(stock_id: stock.id).first
    if user_stock.destroy
      flash[:notice] = "Stock #{stock.name} is not tracked anymore" 
      redirect_to my_portfolio_path
    end
  end

end
