class CurrencyController < ApplicationController

  def first_currency
    #require "open-uri"    #don't need to do this in rails because already built-in

    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    render({:template => "currency_templates/step_one.html.erb"})
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    @from_symbol = params.fetch("from_symbol")

    render({:template => "currency_templates/step_two.html.erb"})
  end

  def conversion
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    @from_symbol = params.fetch("from_symbol")
    @to_symbol = params.fetch("to_symbol")

    @raw_conversion_data = open("https://api.exchangerate.host/convert?from="+@from_symbol+"&to="+@to_symbol).read
    @parsed_conversion_data = JSON.parse(@raw_conversion_data)
    @rate = @parsed_conversion_data.fetch("result")

    render({:template => "currency_templates/step_three.html.erb"})
  end

end