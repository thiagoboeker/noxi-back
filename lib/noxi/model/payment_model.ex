defmodule Noxi.PaymentModel do
  use Noxi.DAO, schema: Noxi.PaymentSchema

  alias Noxi.Getnet
  alias Noxi.PaymentSchema

  def create_payment(order, cc, cc_data) do
    params = %{
      "amount" => order.amount,
      "order" => %{
        "order_id" => order.uid
      },
      "customer" =>  %{
        "customer_id" => "12345",
        "billing_address" =>  %{}
      },
      "credit" =>  %{
        "delayed" => false,
        "save_card_data" => false,
        "transaction_type" => "FULL",
        "number_installments" => order.installment_counts,
        "card" =>  %{
          "number_token" => cc.number_token,
          "cardholder_name" => cc_data["cardholder_name"],
          "expiration_month" => cc_data["expiration_month"],
          "expiration_year" => cc_data["expiration_year"]
        }
      }
    }

    with {:ok, %{status_code: 200} = resp} <- Getnet.create_payment(params) do
      payment = Jason.decode!(resp.body)
      params =
        Map.new()
        |> Map.put("payment_id", payment["payment_id"])
        |> Map.put("order_id", order.id)
        |> Map.put("status", payment["status"])
        |> Map.put("installment_counts", order.installment_counts)
        |> Map.put("credit_card_id", cc.id)

      %PaymentSchema{}
      |> PaymentSchema.changeset(params)
      |> Noxi.Repo.insert()
    end
  end
end
