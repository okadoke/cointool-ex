defmodule CointoolWeb.PageController do
  use CointoolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", content: :welcome)
  end

  def psc(conn, _params) do
    render(conn, "index.html", content: :psc)
  end
end
