defmodule AwesomeList.FileFetcher do
  @callback fetch_raw_file(url :: String.t()) ::
              {:ok, body :: String.t()}
              | {:error, error_text :: String.t()}
end
