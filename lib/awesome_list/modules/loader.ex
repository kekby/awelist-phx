defmodule AwesomeList.Loader do
  alias AwesomeList.GithubApi

  def get_list() do
    GithubApi.fetch_repo()
  end
end
