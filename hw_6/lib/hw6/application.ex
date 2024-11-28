defmodule Hw6.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Hw6.Repo
    ]

    opts = [strategy: :one_for_one, name: Hw6.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
