defmodule AwesomeList.Repo.Migrations.CreateAwesomeItems do
  use Ecto.Migration

  def change do
    create table(:awesome_items) do
      add :title, :string
      add :description, :string
      add :url, :string
      add :stars, :integer
      add :last_commit, :naive_datetime

      timestamps()
    end
  end
end
