defmodule AwesomeListWeb.GithubApiTest do
  use ExUnit.Case
  alias AwesomeList.GithubHttpApi

  setup do
    bypass = Bypass.open()
    url = "http://localhost:#{bypass.port}"
    {:ok, bypass: bypass, url: url }
  end

  test "handle HTTP with 200 status", %{ bypass: bypass, url: url } do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, "body")
    end)

    assert { :ok, "body" } = GithubHttpApi.fetch_raw_file(url)
  end

  test "handle HTTP with error status", %{bypass: bypass, url: url} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 500, "body")
    end)

    assert { :error, "HTTP Status: 500" } = GithubHttpApi.fetch_raw_file(url)
  end

  test "handle request down", %{bypass: bypass, url: url} do
    Bypass.down(bypass)

    assert { :error, :econnrefused } = GithubHttpApi.fetch_raw_file(url)
  end

  test "should return owner name from url" do
    assert "facebook" == GithubHttpApi.get_repo_owner("https://github.com/facebook/react")
    assert :error == GithubHttpApi.get_repo_owner("https://facebook.com/facebook/react")
  end
end
