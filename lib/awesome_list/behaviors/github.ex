defmodule AwesomeList.GithubApi do

  @callback fetch_raw_file(url :: String.t) :: { :ok, body :: String.t } |
                                               { :error, error_text :: String.t }

  @callback get_repo_data(repo_name :: String.t) :: { :ok, %{ stars: integer } } |
                                                    { :error, error_text :: String.t }
end
