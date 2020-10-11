defmodule Noxi.CompanySchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companys" do
    field :name, :string
    field :url_image, :string
    has_many :products, Noxi.ProductSchema, foreign_key: :company_id
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:name, :url_image])
    |> cast_assoc(:products)
  end

end
