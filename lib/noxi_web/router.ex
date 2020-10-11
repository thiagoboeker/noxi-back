defmodule NoxiWeb.Router do
  use NoxiWeb, :router

  import NoxiWeb.Auth.Firebase

  pipeline :api do
    plug :accepts, ["json"]
    plug :firebase_auth
  end

  scope "/api", NoxiWeb do
    post "/user/create", UserController, :create

    pipe_through :api

    scope "/user" do
      get "/", UserController, :get_user
      post "/tokenize_cc", UserController, :tokenize_cc
      post "/points", UserController, :points
      get "/products", ProductController, :index
      get "/companys", CompanyController, :index
    end
  end
end
