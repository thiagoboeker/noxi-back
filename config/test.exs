use Mix.Config

# Configure your database
config :noxi, Noxi.Repo,
  username: "postgres",
  password: "postgres",
  database: "noxi_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :noxi, NoxiWeb.Endpoint,
  http: [port: 4002],
  server: false

config :noxi, :firebase_api_key, "xxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxx"

config :noxi, :client_id, "xxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxx"

config :noxi, :getnet_endpoint, "https://api-sandbox.getnet.com.br"

config :noxi, :client_secret, "xxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxx"
# Print only warnings and errors during test
config :logger, level: :warn
