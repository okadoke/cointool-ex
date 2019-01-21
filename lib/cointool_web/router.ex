defmodule CointoolWeb.Router do
  use CointoolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CointoolWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/tools/psc", PageController, :psc
  end

  # Other scopes may use custom stacks.
  # scope "/api", CointoolWeb do
  #   pipe_through :api
  # end
end
