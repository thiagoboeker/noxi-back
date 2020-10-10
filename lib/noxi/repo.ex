defmodule Noxi.Repo do
  use Ecto.Repo,
    otp_app: :noxi,
    adapter: Ecto.Adapters.Postgres
end
