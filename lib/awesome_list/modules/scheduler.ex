defmodule AwesomeList.Scheduler do
  use Quantum.Scheduler, otp_app: :awesome_list
  alias AwesomeList.{ Awesome, Repo }
  import Ecto.Query, only: [ from: 2 ]
  @max_seconds 86400
  def log_task() do
    Repo.insert(%Awesome.SchedulerTask{
      completed_at: DateTime.utc_now() |> DateTime.truncate(:second)
    })
  end

  def should_run?() do
    last_task = get_last_task()

    if DateTime.diff(DateTime.utc_now(), last_task.completed_at) > @max_seconds do
      true
    else
      false
    end

  end

  def get_last_task() do
    Repo.one!(from t in Awesome.SchedulerTask, order_by: [desc: t.completed_at], limit: 1)
  end

end
