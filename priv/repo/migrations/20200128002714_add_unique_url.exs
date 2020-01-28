defmodule AwesomeList.Repo.Migrations.AddUniqueUrl do
  use Ecto.Migration

  def change do
    create unique_index(:awesome_items, [:url])
  end
end
