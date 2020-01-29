defmodule AwesomeList.Storage do
  alias AwesomeList.{Repo, Awesome}
  import Ecto.Query, only: [from: 2]

  def get_list(stars) do
    Repo.all(from item in Awesome.Item, where: item.stars >= ^stars, select: item)
  end

  def get_list() do
    query = from item in Awesome.Item, preload: [:category]

    Repo.all(query)
  end

  def save_list(list) do
    list
    |> Enum.map(&save_category/1)
    |> List.flatten()
    |> Enum.map(&save_awesome_repos/1)
  end

  defp save_category({title, description, repos}) do
    category = %Awesome.Category{title: title, description: description}

    {:ok, inserted} =
      Repo.insert(
        category,
        on_conflict: {:replace, [:title, :description]},
        conflict_target: :title
      )

    repos
    |> Enum.map(fn r -> Map.put(r, :category, inserted) end)
  end

  defp save_awesome_repos(%{
         category: category,
         name: title,
         description: description,
         repo: %{last_updated: last_updated, stars: stars},
         url: url
       }) do
    awesome_item = %Awesome.Item{
      title: title,
      description: description,
      last_updated: last_updated |> NaiveDateTime.from_iso8601!(),
      stars: stars,
      url: url,
      category: category
    }

    {:ok, _} =
      Repo.insert(
        awesome_item,
        on_conflict: {:replace, [:title, :stars, :last_updated, :description, :category_id]},
        conflict_target: :url
      )
  end
end
