# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

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

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.matches(field_name, param)
    results = where("#{field_name} like ?", "%#{param}%")
    return [] if results.empty?

    results
  end

  def self.match_email(param)
    matches('email', "%#{param}%")
  end

  def self.match_first_name(param)
    matches('first_name', "%#{param}%")
  end

  def self.match_last_name(param)
    matches('last_name', "%#{param}%")
  end

  def self.results(param)
    (match_email(param) + match_first_name(param) + match_last_name(param))
  end
end
