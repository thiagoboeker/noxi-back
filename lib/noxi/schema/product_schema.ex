defmodule Noxi.ProductSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :url_image, :string
    field :price, :integer
    field :points, :integer
    field :buy, :integer
    field :category, :string
    belongs_to :company, Noxi.CompanySchema
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:name, :price, :points, :url_image, :company_id, :buy, :category])
  end
end
