defmodule AwesomeList.GithubApi do
  require Logger

  def fetch_repo() do
    get_client()
  end

  defp get_client() do
    get_repo_url()
    |> Logger.info
    get_access_token
    |> Logger.info
  end

  defp get_repo_url(), do: Application.get_env(:awesome_list, :github_awesome_repo)
  defp get_access_token(), do: Application.get_env(:awesome_list, :github_access_token)
end
