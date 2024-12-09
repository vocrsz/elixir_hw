defmodule Hw5.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :hw_5

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end

  def create_db do
    case Ecto.Adapters.SQLite3.storage_up(Hw5.Repo.config()) do
      :ok -> IO.puts("Database created successfully.")
      {:error, reason} -> IO.puts("Failed to create database: #{inspect(reason)}")
    end
  end
end
