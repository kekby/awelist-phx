defmodule AwesomeList.GithubApiFs do
  @behaviour AwesomeList.GithubApi

  def fetch_raw_file(path) do
    path
    |> File.read
    |> handle_response
  end

  def get_repo_data({ _, _ }) do
    { :ok, %{ stars: 200 } }
  end

  defp handle_response({ :ok, raw_string }) do
    { :ok, raw_string }
  end

  defp handle_response(_) do
    { :error, "Error while reading file"}
  end

end
