defmodule Noxi.Repo.Migrations.Company do
  use Ecto.Migration

  def change do
    create table(:companys) do
      add :name, :string
      add :url_image, :string
    end

    create table(:products) do
      add :name, :string
      add :buy, :integer
      add :price, :integer
      add :url_image, :string
      add :company_id, references(:companys)
      add :points, :integer
      add :category, :string
    end
  end
end
