defmodule AwesomeList.Scheduler do
  use Quantum.Scheduler, otp_app: :awesome_list
  alias AwesomeList.{ Awesome, Repo }

  def log_task() do
    Repo.insert(%Awesome.SchedulerTask{
      completed_at: DateTime.utc_now() |> DateTime.truncate(:second)
    })
  end

end
