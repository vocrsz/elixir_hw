defmodule Hw8.Repo do
  use Ecto.Repo,
    otp_app: :hw_8,
    adapter: Ecto.Adapters.SQLite3
end
