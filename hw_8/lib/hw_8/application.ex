defmodule Hw8.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Hw8Web.Telemetry,
      Hw8.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:hw_8, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:hw_8, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hw8.PubSub},
      {Nx.Serving, serving: serving(), name: MyServing},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hw8.Finch},
      # Start a worker by calling: Hw8.Worker.start_link(arg)
      # {Hw8.Worker, arg},
      # Start to serve requests, typically the last entry
      Hw8Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hw8.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Hw8Web.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end

  def serving do
    {:ok, model_info} =
      Bumblebee.load_model({:hf, "finiteautomata/bertweet-base-emotion-analysis"},
        log_params_diff: false
      )

    {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "vinai/bertweet-base"})

    Bumblebee.Text.text_classification(model_info, tokenizer,
      compile: [batch_size: 10, sequence_length: 100],
      defn_options: [compiler: EXLA]
    )
  end
end
