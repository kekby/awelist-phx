defmodule AwesomeListWeb.GithubApiTest do
  use ExUnit.Case
  alias AwesomeList.GithubApi

  test "should return owner name from url" do
    assert {"facebook", "react"} == GithubApi.get_repo_meta("https://github.com/facebook/react")
    assert :error == GithubApi.get_repo_meta("https://facebook.com/facebook/react")
  end
end
