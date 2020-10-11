defmodule Noxi.Getnet do
  alias Noxi.Getnet.AuthService
  alias Noxi.CreditCardModel

  @getnet_endpoint "https://api-sandbox.getnet.com.br"

  defp post(url, data, token) do
    HTTPoison.post(@getnet_endpoint <> url, Jason.encode!(data), [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{token}"},
      {"Accept", "application/json, text/plain, */*"}
    ])
  end

  defp get(url,token) do
    HTTPoison.get(@getnet_endpoint <> url, [
      {"Authorization", "Bearer #{token}"},
      {"Accept", "application/json, text/plain, */*"}
    ])
  end

  defp generate_token(param, token) do
    post("/v1/tokens/card", %{"card_number" => param}, token)
  end

  defp store_token(resp, %{"data" => data}, token) do
    body = Jason.decode!(:zlib.gunzip(resp.body))
    params = Map.put(data, "number_token", body["number_token"])
    post("/v1/cards", params, token)
  end

  def tokenize_cc(params) do
    {:ok, token} = AuthService.getnet_token()

    with {:ok, %{status_code: 201} = resp} <- generate_token(params["card_number"], token),
         {:ok, %{status_code: 201} = resp} <- store_token(resp, params, token) do
      {:ok, Jason.decode!(:zlib.gunzip(resp.body))}
    end
  end

  defp get_cc_getnet(cc, token) do
    get("/v1/cards/#{cc.card_id}", token)
  end

  def get_cc(id) do
    {:ok, token} = AuthService.getnet_token()

    with {:ok, cc} <- CreditCardModel.show(id),
         {:ok, %{status_code: 200} = resp} <- get_cc_getnet(cc, token) do
      {:ok, Jason.decode!(resp.body), cc}
    end
  end

  def create_payment(params) do
    {:ok, token} = AuthService.getnet_token()
    post("/v1/payments/credit", params, token)
  end
end
