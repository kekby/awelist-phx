defmodule AwesomeList.GithubApi do
  require Logger

  def fetch_repo() do
    get_client()
  end

  defp get_client() do
    get_repo_url()
    |> Logger.info
  end

  defp get_repo_url(), do: Application.get_env(:awesome_list, :github_awesome_repo)
end
