defmodule AwesomeList.SchedulerTest do
  use ExUnit.Case
  use AwesomeList.DataCase
  alias AwesomeList.{Repo, Awesome, Scheduler}

  describe "should_run?/0" do

    test "should return true if scheduler task is not exist" do

      assert Scheduler.should_run?() == true
    end

    test "should return true if last task was launched over 24 hours ago" do
      back_to_past = -86401
      date =
        DateTime.utc_now()
        |> DateTime.add(back_to_past, :second)
        |> DateTime.truncate(:second)

      Repo.insert(%Awesome.SchedulerTask{
        completed_at: date
      })

      assert Scheduler.should_run?() == true
    end

    test "should return false if last task was launched recently (24 hrs max)" do
      back_to_past = -86300
      date =
        DateTime.utc_now()
        |> DateTime.add(back_to_past, :second)
        |> DateTime.truncate(:second)

      Repo.insert(%Awesome.SchedulerTask{
        completed_at: date
      })

      assert Scheduler.should_run?() == false
    end

  end
end
