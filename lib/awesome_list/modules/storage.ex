defmodule AwesomeList.Storage do
  alias AwesomeList.{ Repo, Awesome }
  import Ecto.Query, only: [from: 2]

  def get_list(stars) do
    Repo.all(from item in Awesome.Item, where: item.stars >= ^stars, select: item)
  end

  def get_list() do
    Repo.all(Awesome.Item)
  end

  def save_list(list) do
    list 
  end
end
