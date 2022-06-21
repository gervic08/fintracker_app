# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def under_max_tracked_stocks?
    stocks.count < 10
  end

  def stock_already_tracked?(ticker)
    stock = stocks.where(ticker: ticker)
    return true if stock.empty?

    false
  end

  def can_track_stock?(ticker)
    under_max_tracked_stocks? && stock_already_tracked?(ticker)
  end
end
