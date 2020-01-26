defmodule AwesomeList.FileFetcherHttp do
  @behaviour AwesomeList.FileFetcher

  def fetch_raw_file(url) do
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
end
