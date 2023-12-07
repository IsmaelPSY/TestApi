defmodule TestApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :test_api,
  module: TestApiWeb.Auth.Guardian,
  error_handler: TestApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
