# import socket from "../../js/socket.js"
let socket = require('../../js/socket'):default

export tag PriceTicker

  prop label
  prop ticker
  
  def build
    @price = 0.0

  def request_price
    socket:price_channel.push('get_price', {ticker: @ticker})

  def setup
    socket:price_channel.on(@ticker, do |payload|
      setTimeout(&, 5000) do request_price
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