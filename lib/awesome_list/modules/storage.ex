defmodule AwesomeList.Storage do
  alias AwesomeList.{Repo, Awesome}
  import Ecto.Query, only: [from: 2]

  def get_list(stars) do
    Repo.all(from item in Awesome.Item, where: item.stars >= ^stars, select: item)
  end

  def get_list() do
    Repo.all(Awesome.Item)
  end

  def save_list(list) do
    list
    |> Enum.map(&save_category/1)
    |> List.flatten()
    |> Enum.map(&save_awesome_repos/1)
  end

  defp save_category({title, description, repos}) do
    on_conflict = [set: [description: description]]

    {:ok, inserted} =
      Repo.insert(
        %Awesome.Category{
          title: title,
          description: description
        },
        on_conflict: :replace_all,
        conflict_target: :title
      )

    repos
    |> Enum.map(fn r -> Map.put(r, :category, inserted.id) end)
  end

  defp save_awesome_repos(
         awesome_repo = %{
           category: category_id,
           name: title,
           description: description,
           repo: %{last_updated: last_updated, stars: stars},
           url: url
         }
       )
       when is_integer(category_id) do
    awesome_item = %Awesome.Item{
      title: title,
      description: description,
      last_updated: last_updated |> NaiveDateTime.from_iso8601!(),
      stars: stars,
      url: url
    }

    # character = Ecto.build_assoc(movie, :characters, %{name: "Wade Watts"})
    # { :ok, inserted } = Repo.insert(
    #  ,
    #   on_conflict: :replace_all,
    #   conflict_target: :url
    # )
  end
end
