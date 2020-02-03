defmodule AwesomeList.Repo.Migrations.CreateSchedulerTasks do
  use Ecto.Migration

  def change do
    create table(:scheduler_tasks) do
      add :completed_at, :utc_datetime
    end

  end
end
