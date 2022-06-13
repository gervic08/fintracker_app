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
end
