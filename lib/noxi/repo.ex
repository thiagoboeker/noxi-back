defmodule Noxi.Repo do
  use Ecto.Repo,
    otp_app: :noxi,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 20
end
