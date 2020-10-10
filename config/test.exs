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

config :noxi, :firebase_api_key, "AIzaSyBkmp2bZUTuTi4K6Z_JQywboZXJrVyLLsI"

config :noxi, :client_id, "93f984b1-8ba9-4895-b7b3-08f9a1032085"

config :noxi, :getnet_endpoint, "https://api-sandbox.getnet.com.br"

config :noxi, :client_secret, "5cc8032c-a321-44cf-ab51-d843fbd14d3b"
# Print only warnings and errors during test
config :logger, level: :warn
