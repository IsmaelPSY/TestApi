defmodule TestApiWeb.Router do
  use TestApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TestApiWeb do
    pipe_through :api
    get "/", DefaulController, :index
  end
end
