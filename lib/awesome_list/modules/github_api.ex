defmodule AwesomeList.GithubApi do
  require Logger
  alias AwesomeList.MdParser

  def get_parsed() do
    fetch_repo()
    |> parse
  end

  def fetch_repo() do
    get_repo_url()
    |> HTTPoison.get
    |> handle_response
  end

  defp handle_response({ :ok, %{ body: body, status_code: 200 } }) do
    { :ok, body }
  end

  defp handle_response({ :ok, %{ status_code: status_code }}) do
    { :error, "HTTP Status: #{status_code}" }
  end

  defp handle_response({ :error, %{ reason: reason } }), do: { :error, reason }

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
