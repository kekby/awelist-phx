defmodule AwesomeList.GithubApi do
  require Logger
  alias AwesomeList.MdParser

  def fetch_repo() do
    get_repo_url()
    |> HTTPoison.get
    |> handle_response
    |> parse
  end

  defp handle_response({ :ok, %{ body: body, status_code: 200 } }) do
    { :ok, body }
  end

  defp handle_response(_) do
    { :error, "error in http request" }
  end

  defp parse({ :ok, body }) do
    body |> MdParser.parse
  end

  defp parse({ :error, error }), do: error

  defp get_client() do
    Tentacat.Client.new(%{ access_token: get_access_token() })
  end

  defp get_repo_url(), do: Application.get_env(:awesome_list, :github_awesome_repo)
  defp get_access_token(), do: Application.get_env(:awesome_list, :github_access_token)
end
