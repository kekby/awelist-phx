defmodule AwesomeList.Repo.Migrations.AddUniq do
  use Ecto.Migration

  def change do
    create unique_index(:categories, [:title])
  end
end
