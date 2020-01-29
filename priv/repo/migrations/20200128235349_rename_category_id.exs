defmodule AwesomeList.Repo.Migrations.RenameCategoryId do
  use Ecto.Migration

  def change do
    rename table(:awesome_items), :category, to: :category_id
  end
end
