# frozen_string_literal: true

class Stock < ApplicationRecord
  def self.lookup(ticker)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_api[:iex_sandbox_key],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker, name: client.company(ticker).company_name, price: client.price(ticker))
    rescue => e
      nil
    end
  end
end
