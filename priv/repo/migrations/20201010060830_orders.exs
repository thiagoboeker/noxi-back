defmodule Noxi.Repo.Migrations.Orders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :uid, :string
      add :amount, :integer
      add :installment_counts, :integer
      add :credit_card_id, references(:credit_cards)
      timestamps(type: :utc_datetime)
    end
  end
end
