defmodule AwesomeList.GithubHttpApi do
  @behaviour AwesomeList.GithubApi

  def fetch_raw_file(url) do
    url
    |> HTTPoison.get
    |> handle_response
  end

  def get_repo_data({ repo_name, url }) do
    owner = get_repo_owner(url)

    get_client()
    |> Tentacat.Repositories.repo_get(owner, repo_name)
    |> handle_repo_response
  end

  def get_repo_owner(url) do
    matcher = ~r/github.com\/(.*)\//

    case Regex.run(matcher, url) do
      [ _, owner ] -> owner
      _ -> :error
    end

  end

  defp handle_response({ :ok, %{ body: body, status_code: 200 } }) do
    { :ok, body }
  end

  defp handle_response({ :ok, %{ status_code: status_code }}) do
    { :error, "HTTP Status: #{status_code}" }
  end

  defp handle_response({ :error, %{ reason: reason } }), do: { :error, reason }

  defp get_client() do
    Tentacat.Client.new(%{ access_token: get_access_token() })
  end

  defp get_access_token(), do: Application.get_env(:awesome_list, :github_access_token)

  defp handle_repo_response({ 200, %{ "stargazers_count" => stars }, _ }) do
    { :ok, %{ stars: stars }}
  end

  defp handle_repo_response({ status, _, _ }) do
    { :error, "HTTP Status: #{status}" }
  end
end
