defmodule AwesomeList.Loader do
  alias AwesomeList.{ MdParser, GithubApi }
  @timeout :infinity 

  def get_list() do
    api = get_file_api()

    get_repo_url()
      |> api.fetch_raw_file()
      |> parse_response()
      |> transform_categories()
  end

  defp parse_response({ :ok, body }) do
    body
    |> MdParser.parse()
  end

  defp parse_response(error), do: error

  defp transform_categories(list) do
    list
      # TODO: remove this
      |> Enum.take(2)
      |> Task.async_stream(&fetch_data_about_repos/1, timeout: @timeout)
      |> Enum.map(fn {:ok, result} -> result end)
  end

  defp fetch_data_about_repos({ title, description, repos }) do
    repos
      # TODO: remove this
      |> Enum.take(2)
      |> Task.async_stream(fn %{ link: link } -> GithubApi.get_repo_data(link) end)
      |> Enum.map(fn {:ok, result} -> { title, description, result } end)
      |> IO.inspect
  end


  defp get_file_api() do
    Application.get_env(:awesome_list, :file_fetch_api)
  end

  defp get_repo_url(), do: Application.get_env(:awesome_list, :github_awesome_repo)
end
