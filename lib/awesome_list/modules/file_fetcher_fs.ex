defmodule AwesomeList.FileFetcherFs do
  @behaviour AwesomeList.FileFetcher

  def fetch_raw_file(path) do
    path
    |> File.read()
    |> handle_response
  end

  defp handle_response({:ok, raw_string}) do
    {:ok, raw_string}
  end

  defp handle_response(_) do
    {:error, "Error while reading file"}
  end
end
