defmodule NoxiWeb.ProductView do
  use NoxiWeb.Views, model: Noxi.ProductModel

  def build(%{item: item}) do
    %{
      id: item.id,
      name: item.name,
      image_url: item.url_image,
      price: item.price,
      points: item.points
    }
  end
end
