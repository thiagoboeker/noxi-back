defmodule NoxiWeb.PaymentView do
  use NoxiWeb.Views, model: Noxi.PaymentModel

  def build(%{item: item}) do
    %{
      order_id: item.order_id,
      status: item.status,
      installment_counts: item.installment_counts,
      credit_card_id: item.credit_card_id
    }
  end
end
