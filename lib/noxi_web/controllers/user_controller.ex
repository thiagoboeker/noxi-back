defmodule NoxiWeb.UserController do
  use NoxiWeb, :controller
  use NoxiWeb.Routes, model: Noxi.UserModel
  alias Noxi.Getnet

  def get_user(conn, _params) do
    {:ok, auth} = conn.private.auth

    conn
    |> put_status(:ok)
    |> put_resp_content_type("application/json")
    |> render("show.json", %{item: auth.user})
  end


  def tokenize_cc(conn, %{"param" => params}) do
    {:ok, auth} = conn.private.auth

    put_user_id = fn cc_data ->
      {:ok,
        cc_data
        |> Map.put("user_id", auth.user.id)
        |> Map.put("last4", String.slice(params["card_number"], -5..-1))}
    end

    with {:ok, cc_data} <- Getnet.tokenize_cc(params),
         {:ok, cc_data} <- put_user_id.(cc_data),
         {:ok, cc} <- Noxi.CreditCardModel.create(cc_data) do
      conn
      |> put_status(:ok)
      |> put_resp_content_type("application/json")
      |> put_view(NoxiWeb.CreditCardView)
      |> render("show.json", %{item: cc})
    end
  end

  def points(conn, %{"param" => %{"credit_card_id" => cc_id} = params}) do
    with {:ok, cc_data, cc} <- Getnet.get_cc(cc_id),
         {:ok, order} <- Noxi.OrderModel.create_order(params, cc),
         {:ok, payment} <- Noxi.PaymentModel.create_payment(order, cc, cc_data) do
      conn
      |> put_status(:ok)
      |> put_resp_content_type("application/json")
      |> put_view(NoxiWeb.PaymentView)
      |> render("show.json", %{item: payment})
    end
  end
end
