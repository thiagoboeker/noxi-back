defmodule Noxi.Repo.Migrations.CreditCard do
  use Ecto.Migration

  def change do
    create table(:credit_cards) do
      add :number_token, :string
      add :card_id, :string
      add :user_id, references(:users)
      add :last4, :string
    end
  end
end
