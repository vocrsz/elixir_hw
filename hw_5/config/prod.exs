import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Hw5.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :hw5, Hw5Web.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  url: [host: "localhost", port: 4000],
  server: true,
  secret_key_base: System.get_env("SECRET_KEY_BASE")
