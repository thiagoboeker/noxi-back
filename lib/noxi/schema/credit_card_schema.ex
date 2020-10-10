defmodule Noxi.CreditCardSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credit_cards" do
    field :number_token, :string
    field :card_id, :string
    field :last4, :string
    belongs_to :user, Noxi.UserSchema
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:number_token, :last4, :card_id, :user_id])
  end
end
