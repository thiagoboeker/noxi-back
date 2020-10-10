defmodule Noxi.Getnet.AuthService do
  use GenServer

  @client_id Application.fetch_env!(:noxi, :client_id)

  @client_secret Application.fetch_env!(:noxi, :client_secret)

  @getnet_endpoint Application.fetch_env!(:noxi, :getnet_endpoint)

  def start_link(_) do
    GenServer.start_link(__MODULE__, :state, name: :auth_service)
  end

  def generate_token() do
    "Basic #{Base.encode64("#{@client_id}:#{@client_secret}")}"
  end

  def request() do
    HTTPoison.post(@getnet_endpoint <> "/auth/oauth/v2/token?scope=oob&grant_type=client_credentials", [], [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Authorization", generate_token()},
      {"Accept", "application/json, text/plain, */*"}
    ])
  end

  def init(_) do
    with {:ok, %{status_code: 200} = resp} <- request() do
      {:ok, %{body: Jason.decode!(resp.body), request: resp}}
    end
  end

  def handle_call(:get, _from, state) do
    {:reply, {:ok, state.body["access_token"]}, state}
  end

  def getnet_token() do
    GenServer.call(:auth_service, :get)
  end
end
