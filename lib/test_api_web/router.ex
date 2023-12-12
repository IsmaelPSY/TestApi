defmodule TestApiWeb.Router do
  use TestApiWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: _reason} = error) do
    IO.inspect(error, label: "USER:::")
    conn |> json(%{errors: "Some error"}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug TestApiWeb.Auth.Pipeline
  end

  scope "/api", TestApiWeb do
    pipe_through :api
    get "/", DefaultController, :index

    scope "/accounts" do
      post "/create", AccountController, :create
      post "/sign_in", AccountController, :sign_in
    end
  end

  scope "/api", TestApiWeb do
    pipe_through [:api, :auth]

    scope "/accounts" do
      get "/:id", AccountController, :show
      put "/:id", AccountController, :update
      delete "/:id", AccountController, :delete
    end

    scope "/transactions" do
      post "/create", TransactionController, :create
      get "/:id", TransactionController, :show
      get "/all/:status", TransactionController, :all
    end
  end
end
