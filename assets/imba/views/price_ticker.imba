import { price_channel } from "../../js/socket.js"

export tag PriceTicker

  prop label
  prop ticker
  
  def build
    @price = 0.0

  def request_price
    price_channel.push('get_price', {ticker: @ticker})
    setTimeout(&, 10000) do request_price

  def setup
    price_channel.on(@ticker, do |payload|
      @price = payload:price
      console.log('price received for', @ticker, ':', @price)
      Imba.commit()
    )
    # udpate price every 5s
    # initiate the price request loop
    request_price

  def render
    <self>
      <div.heading> @label
      <div> @price