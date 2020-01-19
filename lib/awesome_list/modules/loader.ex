defmodule AwesomeList.Loader do
  require Logger
  alias AwesomeList.GithubApi

  def get_list() do
    GithubApi.fetch_repo()
  end
end
