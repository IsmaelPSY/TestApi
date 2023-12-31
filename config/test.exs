import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :test_api, TestApi.Repo,
  username: "backend",
  password: "170520210921",
  hostname: "localhost",
  database: "test_api_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :test_api, TestApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "rE3MIfC+Sd4TN0nSzu7HlS93LlJIQ1mvJLEqlZ1AmFemvmX2B6dc2m/rPN8EPW2k",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

config :test_api, Oban, testing: :inline

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
