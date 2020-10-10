defmodule Noxi.PaymentSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :status, :string
    field :installment_counts, :integer
    field :payment_id, :string
    belongs_to :order, Noxi.OrderSchema
    belongs_to :credit_card, Noxi.CreditCardSchema
    timestamps(type: :utc_datetime)
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:status, :payment_id, :installment_counts, :order_id, :credit_card_id])
  end
end
