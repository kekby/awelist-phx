defmodule AwesomeList.Storage do
  alias AwesomeList.Repo
  alias AwesomeList.Awesome

  def get_list(stars) do
    Repo
  end

  def get_list() do
    Repo.all(Awesome.Item)
  end
end
