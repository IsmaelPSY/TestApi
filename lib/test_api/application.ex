defmodule TestApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Oban.Telemetry.attach_default_logger()

    children = [
      TestApiWeb.Telemetry,
      TestApi.Repo,
      {Oban, Application.fetch_env!(:test_api, Oban)},
      {DNSCluster, query: Application.get_env(:test_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TestApi.PubSub},
      # Start a worker by calling: TestApi.Worker.start_link(arg)
      # {TestApi.Worker, arg},
      # Start to serve requests, typically the last entry
      TestApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
