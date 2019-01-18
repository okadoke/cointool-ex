defmodule CointoolWeb.PriceChannel do
  use Phoenix.Channel

  def join("price:source", _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_price", %{"ticker" => ticker}, socket) do
    price = PriceCache.get_price(ticker)
    push(socket, ticker, %{price: price})
    {:noreply, socket}
  end
end
