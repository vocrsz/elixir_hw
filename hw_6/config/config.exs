import Config

config :hw_6, Hw6.Repo,
  database: "my_app.sqlite.db",
  pool_size: 5,
  journal_mode: :wal

config :hw_6, ecto_repos: [Hw6.Repo]

import_config "#{config_env()}.exs"
