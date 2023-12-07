defmodule TestApiWeb.Router do
  use TestApiWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: _reason}) do
    conn |> json(%{errors: "Some error"}) |> halt()
  end

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
      post "/sign_in", AccountController, :sign_in
      put "/:id", AccountController, :update
      delete  "/:id", AccountController, :delete
    end

    post "/validate_time", ValidateController, :validate

  end
end
