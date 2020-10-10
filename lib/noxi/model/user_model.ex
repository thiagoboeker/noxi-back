defmodule Noxi.UserModel do
  use Noxi.DAO, schema: Noxi.UserSchema

  alias Noxi.UserSchema
  alias NoxiWeb.Auth.Firebase
  alias Noxi.Repo

  def create(%{"email" => email, "password" => password} = params) do
    with {:ok, %{status_code: 200}} <- Firebase.create_user(%{email: email, password: password}) do
      %UserSchema{}
      |> UserSchema.changeset(params)
      |> Repo.insert()
    end
  end
end
