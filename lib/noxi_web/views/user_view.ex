defmodule NoxiWeb.UserView do
  use NoxiWeb.Views, model: Noxi.UserModel

  def build(%{item: item}) do
    %{
      id: item.id,
      name: item.name,
      email: item.email
    }
  end
end
