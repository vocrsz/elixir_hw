defmodule Hw6.Repo do
  use Ecto.Repo,
    otp_app: :hw_6,
    adapter: Ecto.Adapters.SQLite3
end
