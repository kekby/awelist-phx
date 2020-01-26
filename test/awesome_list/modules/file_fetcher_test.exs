defmodule AwesomeListWeb.FileFetcherTest do
  use ExUnit.Case
  alias AwesomeList.FileFetcherHttp

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

    assert { :ok, "body" } = FileFetcherHttp.fetch_raw_file(url)
  end

  test "handle HTTP with error status", %{bypass: bypass, url: url} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 500, "body")
    end)

    assert { :error, "HTTP Status: 500" } = FileFetcherHttp.fetch_raw_file(url)
  end

  test "handle request down", %{bypass: bypass, url: url} do
    Bypass.down(bypass)

    assert { :error, :econnrefused } = FileFetcherHttp.fetch_raw_file(url)
  end

end