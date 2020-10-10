defmodule NoxiWeb.CreditCardView do
  use NoxiWeb.Views, model: Noxi.CreditCardModel

  def build(%{item: item}) do
    %{
      id: item.id,
      card_id: item.card_id,
      number_token: item.number_token,
      last4: item.last4
    }
  end
end
