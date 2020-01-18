defmodule AwesomeListWeb.HelpersTest do
  use AwesomeListWeb.ConnCase, async: true

  test "should return a proper star" do
    assert AwesomeListWeb.Helpers.List.get_stars_icon(50) == "⭐"
    assert AwesomeListWeb.Helpers.List.get_stars_icon(1509) == "🌟"
  end
end
