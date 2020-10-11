defmodule Noxi.ProductModel do
  use Noxi.DAO, schema: Noxi.ProductSchema
  import Ecto.Query

  def category_filter(params) do
    dynamic([product], ilike(product.category, ^"%#{params["category"]}%"))
  end
end
