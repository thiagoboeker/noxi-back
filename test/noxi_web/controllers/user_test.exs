defmodule NoxiWeb.UserTest do
  use NoxiWeb.ConnCase

  alias NoxiWeb.Auth.Firebase

  def auth(conn, email) do
    {:ok, %{status_code: 200} = resp} = Firebase.sign_in(%{email: email, password: "123123"})
    body = Jason.decode!(resp.body)

    conn
    |> put_req_header("authorization", "Bearer #{body["idToken"]}")
  end

  def create_user(email) do
    build_conn()
    |> post("/api/user/create", %{
      "param" => %{"email" => email, "name" => "Thiago Boeker", "password" => "123123"}
    })
    |> json_response(201)
  end

  test "CREATE/GET USER" do
    email = "thiago#{Ecto.UUID.autogenerate()}@gmail.com"

    build_conn()
    |> post("/api/user/create", %{
      "param" => %{"email" => email, "name" => "Thiago Boeker", "password" => "123123"}
    })
    |> json_response(201)

    build_conn()
    |> auth(email)
    |> get("/api/user")
    |> json_response(200)
  end

  test "GETNET - TOKENIZE/PAYMENT" do
    email = "thiago#{Ecto.UUID.autogenerate()}@gmail.com"

    create_user(email)

    credit_card = %{
      "card_number" => "5155901222280001",
      "data" => %{
        "cardholder_name" => "JOAO DA SILVA",
        "expiration_month" => "12",
        "expiration_year" => "21",
        "customer_id" => "12345"
      }
    }

    credit_card =
      build_conn()
      |> auth(email)
      |> post("/api/user/tokenize_cc", %{"param" => credit_card})
      |> json_response(200)
      |> Map.get("data")

    payment = %{
      "amount" => 1000,
      "credit_card_id" => credit_card["id"],
      "installment_counts" => 1
    }

    credit_card =
      build_conn()
      |> auth(email)
      |> post("/api/user/points", %{"param" => payment})
      |> json_response(200)
  end
end
