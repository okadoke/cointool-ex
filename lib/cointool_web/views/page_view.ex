defmodule CointoolWeb.PageView do
  use CointoolWeb, :view

  def btc_price() do
    PriceCache.get_price("BTC/USD", 10)
  end
end
