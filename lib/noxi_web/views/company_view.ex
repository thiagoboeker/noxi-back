defmodule NoxiWeb.CompanyView do
  use NoxiWeb.Views, model: Noxi.CompanyModel

  def build(%{item: item}) do
    %{
      id: item.id,
      name: item.name,
      image_url: item.url_image
    }
  end
end
