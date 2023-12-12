# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :test_api,
  ecto_repos: [TestApi.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :test_api, TestApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: TestApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TestApi.PubSub,
  live_view: [signing_salt: "DGrh4Gu/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :test_api, TestApiWeb.Auth.Guardian,
  issuer: "test_api",
  secret_key: "hO1D9PvE5YPlzo+R1qCcygyQuaIcqy/d1xO8OoICkrjuGcLKRUKSj15p8GzfoH4U"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :test_api, Oban,
  repo: TestApi.Repo,
  plugins: [
    # deleting completed, cancelled and discarded jobs after one week.
    {Oban.Plugins.Pruner, max_age: 60 * 5},
    # rescue orphans jobs
    {Oban.Plugins.Lifeline, rescue_after: :timer.minutes(30)}
  ],
  queues: [default: 10, failed: 5, completed: 5]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
