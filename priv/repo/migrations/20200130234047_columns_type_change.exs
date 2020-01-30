defmodule AwesomeList.Repo.Migrations.ColumnsTypeChange do
  use Ecto.Migration

  def change do
    alter table(:awesome_items) do
      modify :description, :text
    end

    alter table(:categories) do
      modify :description, :text
    end
  end
end
