defmodule AwesomeList.GithubApi do
  require Logger

  def get_repo_data({repo_name, url}) do
    case get_repo_meta(url) do
      {owner, name} -> %{name: repo_name, url: url, repo: fetch_repo(owner, name)}
      _ -> nil
    end
  end

  def get_repo_meta(url) do
    matcher = ~r/github.com\/(.*)\/(.*)/

    case Regex.run(matcher, url) do
      [_, owner, name] -> {owner, name}
      _ -> :error
    end
  end

  defp fetch_repo(owner, name) do

    get_stars(owner, name)
    |> add_last_commit_date()
  end


  defp get_stars(owner, name) do
    get_client()
    |> Tentacat.Repositories.repo_get(owner, name)
    |> handle_repo_response(name)
  end

  defp add_last_commit_date(repo_data = %{ name: name, owner: owner }) do
    get_client()
    |> Tentacat.Repositories.Branches.find(owner, name, "master")
    |> handle_repo_response(name)
    |> Map.merge(repo_data)
  end

  defp add_last_commit_date(_), do: nil

  defp handle_repo_response(
         {200,
          %{
            "stargazers_count" => stars,
            "owner" => %{ "login" => owner_name },
          }, _},
         name
       ) do
    %{
      stars: stars,
      owner: owner_name,
      name: name
    }
  end

  defp handle_repo_response(
         {200,
          %{
            "commit" => %{ "commit" => %{ "author" => %{ "date" => last_updated } } },
          }, _},
         _
       ) do
    %{
      last_updated: last_updated
    }
  end

  defp handle_repo_response({status, _, _}, repo_name) do
    Logger.warn("HTTP Status: #{status} on repo: #{repo_name}.")
    %{}
  end

  defp get_client() do
    Tentacat.Client.new(%{access_token: get_access_token()})
  end

  defp get_access_token(), do: Application.get_env(:awesome_list, :github_access_token)
end
