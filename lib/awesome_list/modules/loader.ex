defmodule AwesomeList.Loader do
  alias AwesomeList.{ GithubApi, MdParser }

  def get_list() do
    GithubApi.fetch_repo()
    |> parse_response()
  end

  defp parse_response({ :ok, body }) do
    body
    |> MdParser.parse()
  end

  defp parse_response(error), do: error
end
