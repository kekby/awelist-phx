defmodule AwesomeList.Loader do
  alias AwesomeList.{ MdParser }

  def get_list() do
    api = get_api()

    get_repo_url()
    |> api.fetch_repo()
    |> parse_response()

  end

  defp parse_response({ :ok, body }) do
    body
    |> MdParser.parse()
  end

  defp parse_response(error), do: error

  defp get_api() do
    Application.get_env(:awesome_list, :github_api)
  end

  defp get_repo_url(), do: Application.get_env(:awesome_list, :github_awesome_repo)
end
