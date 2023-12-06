defmodule TestApiWeb.Router do
  use TestApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TestApiWeb do
    pipe_through :api
    get "/", DefaultController, :index

    scope "/accounts" do
      get "/", AccountController, :index
      get "/:id", AccountController, :show
      post "/create", AccountController, :create
    end
  end

end
