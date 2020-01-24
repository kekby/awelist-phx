defmodule AwesomeList.GithubApi do

  @callback fetch_repo(url :: String.t) :: { :ok, body :: String.t } |
                                           { :error, error_text :: String.t }

end
