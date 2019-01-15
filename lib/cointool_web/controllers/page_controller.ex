defmodule CointoolWeb.PageController do
  use CointoolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
