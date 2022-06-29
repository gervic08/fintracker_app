# frozen_string_literal: true

class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/results.js' }
        end
      else
        flash.now[:alert] = "Please input a valid ticker symbol"
        respond_to do |format|
          format.js { render partial: 'users/results.js' }
        end  
      end
    else
      flash.now[:alert] = "Please input a ticker symbol"
      respond_to do |format|
        format.js { render partial: 'users/results.js' }
      end
    end
  end

  def update
    @stock = current_user.stocks.find_by(ticker: params[:ticker])
    price = @stock.update_price
    if @stock.update_attribute :price, price
      respond_to do |format|
        format.js { render partial: 'list', locals: { stock: @stock } }
      end
    end
  end
end
