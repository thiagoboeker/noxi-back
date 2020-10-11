defmodule Noxi.Repo.Migrations.SaldoUsuario do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :credits, :integer
    end
  end
end
