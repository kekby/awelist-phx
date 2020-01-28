defmodule AwesomeList.Repo.Migrations.AddReferenceToCategory do
  use Ecto.Migration

  def change do
    alter table(:awesome_items) do
      add :category, references(:categories)
    end
  end
end
