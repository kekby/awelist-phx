defmodule AwesomeList.Awesome.SchedulerTask do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scheduler_tasks" do
    field :completed_at, :utc_datetime
  end

  @doc false
  def changeset(scheduler_task, attrs) do
    scheduler_task
    |> cast(attrs, [:completed_at])
    |> validate_required([:completed_at])
  end
end
