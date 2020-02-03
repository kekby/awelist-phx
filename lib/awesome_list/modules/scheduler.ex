defmodule AwesomeList.Scheduler do
  use Quantum.Scheduler, otp_app: :awesome_list
  alias AwesomeList.{ Awesome, Repo }
  require Logger
  import Ecto.Query, only: [ from: 2 ]
  @max_seconds 86400
  def log_task() do
    Repo.insert(%Awesome.SchedulerTask{
      completed_at: DateTime.utc_now() |> DateTime.truncate(:second)
    })
  end

  def should_run?() do
    get_last_task()
    |> check_task()
  end

  def get_last_task() do
    Repo.one(from t in Awesome.SchedulerTask, order_by: [desc: t.completed_at], limit: 1)
  end

  defp check_task(task) do

    case task do
      # always run if scheduler have no logs in persist storage
      nil  -> true
      task ->
        last_runned_in_seconds = DateTime.diff(DateTime.utc_now(), task.completed_at)
        if last_runned_in_seconds > @max_seconds do
          Logger.warn "Task is last runned at #{div(last_runned_in_seconds,3600)} hrs ago"
          true
        else
          false
        end
      end
  end
end
