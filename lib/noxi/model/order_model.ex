defmodule Noxi.OrderModel do
  use Noxi.DAO, schema: Noxi.OrderSchema
  alias Noxi.Repo

  def create_order(params, cc) do
    params =
      params
      |> Map.put("credit_card_id", cc.id)
      |> Map.put("uid", Ecto.UUID.autogenerate())
      
    %Noxi.OrderSchema{}
    |> Noxi.OrderSchema.changeset(params)
    |> Repo.insert()
  end
end
