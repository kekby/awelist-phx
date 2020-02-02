defmodule AwesomeList.Loader do
  alias AwesomeList.{MdParser, GithubApi, Storage}
  @timeout :infinity

  def get_and_save_list() do
    api = get_file_api()

    get_repo_url()
    |> api.fetch_raw_file()
    |> parse_response()
    |> transform_categories()
    |> Storage.save_list()
  end

  defp parse_response({:ok, body}) do
    body
    |> MdParser.parse()
  end

  defp parse_response(error), do: error

  defp transform_categories(list) do
    list
    |> Task.async_stream(&fetch_data_about_repos/1, timeout: @timeout)
    |> Enum.map(fn {:ok, result} -> result end)
  end

  defp fetch_data_about_repos({title, description, repos}) do
    new_repos =
      repos
      |> Task.async_stream(fn %{link: link, description: description} ->
        repo_data = GithubApi.get_repo_data(link)

        case repo_data do
          nil -> nil
          _ -> Map.put(repo_data, :description, description)
        end
      end)
      |> Enum.map(fn {:ok, result} -> result end)
      |> Enum.filter(fn item -> is_map(item) end)

    {title, description, new_repos}
  end

  defp get_file_api() do
    Application.get_env(:awesome_list, :file_fetch_api)
  end

  defp get_repo_url(), do: Application.get_env(:awesome_list, :github_awesome_repo)
end
