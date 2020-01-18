defmodule AwesomeListWeb.Router do
  use AwesomeListWeb, :router

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

  scope "/", AwesomeListWeb do
    pipe_through :browser

    get "/", ListController, :index

  end

  scope "/", AwesomeListWeb do
    get "/*path", ListController, :redirect_to_main
  end

  # Other scopes may use custom stacks.
  # scope "/api", AwesomeListWeb do
  #   pipe_through :api
  # end
end
