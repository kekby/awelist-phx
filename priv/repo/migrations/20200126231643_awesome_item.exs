defmodule AwesomeList.Repo.Migrations.AwesomeItem do
  use Ecto.Migration

  def change do
    rename table(:awesome_items), :last_commit, to: :last_updated
  end
end
