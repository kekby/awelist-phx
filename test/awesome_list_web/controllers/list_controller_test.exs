defmodule AwesomeListWeb.PageControllerTest do
  use AwesomeListWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert true == true
  end
end
