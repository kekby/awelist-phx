defmodule AwesomeList.GithubHttpApi do
  @behaviour AwesomeList.GithubApi

  def fetch_repo(url) do
    url
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

  # defp get_client() do
  #   Tentacat.Client.new(%{ access_token: get_access_token() })
  # end

  # defp get_access_token(), do: Application.get_env(:awesome_list, :github_access_token)
end
