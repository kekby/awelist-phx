defmodule AwesomeList.Storage do
  alias AwesomeList.Repo
  alias AwesomeList.Awesome
  import Ecto.Query, only: [from: 2]

  def get_list(stars) do
    Repo.all(from item in Awesome.Item, where: item.stars >= ^stars, select: item)
  end

  def get_list() do
    Repo.all(Awesome.Item)
  end
end
