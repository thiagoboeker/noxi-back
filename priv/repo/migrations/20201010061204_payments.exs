defmodule Noxi.Repo.Migrations.Payments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :order_id, :id
      add :status, :string
      add :installment_counts, :integer
      add :payment_id, :string
      add :credit_card_id, references(:credit_cards)
      timestamps(type: :utc_datetime)
    end
  end
end
