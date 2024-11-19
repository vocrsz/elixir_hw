defmodule Hw5.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Hw5Web.Telemetry,
      Hw5.Repo,
      {DNSCluster, query: Application.get_env(:hw_5, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hw5.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hw5.Finch},
      # Start a worker by calling: Hw5.Worker.start_link(arg)
      # {Hw5.Worker, arg},
      # Start to serve requests, typically the last entry
      Hw5Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hw5.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Hw5Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
