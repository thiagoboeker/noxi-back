defmodule Noxi.UserSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :credits, :integer
    timestamps(type: :utc_datetime)
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:name, :credits, :email])
    |> unique_constraint(:email)
  end
end
