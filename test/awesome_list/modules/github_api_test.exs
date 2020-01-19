defmodule AwesomeListWeb.GithubApiTest do
  use ExUnit.Case
  alias AwesomeList.GithubApi

  setup do
    bypass = Bypass.open()
    Application.put_env(:awesome_list, :github_awesome_repo, "http://localhost:#{bypass.port}")
    {:ok, bypass: bypass}
  end

  test "handle HTTP with 200 status", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, "body")
    end)

    assert { :ok, "body" } = GithubApi.fetch_repo()
  end

  test "handle HTTP with error status", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 500, "body")
    end)

    assert { :error, "HTTP Status: 500" } = GithubApi.fetch_repo()
  end

  test "handle request down", %{bypass: bypass} do
    Bypass.down(bypass)

    assert { :error, :econnrefused } = GithubApi.fetch_repo()
  end
end
