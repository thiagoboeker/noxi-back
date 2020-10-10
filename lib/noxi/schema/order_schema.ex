defmodule Noxi.OrderSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :uid, :string
    field :amount, :integer
    field :installment_counts, :integer
    belongs_to :credit_card, Noxi.CreditCardSchema
    timestamps(type: :utc_datetime)
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:uid, :amount, :installment_counts, :credit_card_id])
  end
end
