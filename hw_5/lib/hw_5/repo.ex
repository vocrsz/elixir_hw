defmodule Hw5.Repo do
  use Ecto.Repo,
    otp_app: :hw_5,
    adapter: Ecto.Adapters.SQLite3
end
