defmodule AwesomeListWeb.HelpersTest do
  use AwesomeListWeb.ConnCase, async: true
  alias AwesomeListWeb.Helpers

  test "should return a proper star" do
    assert Helpers.List.get_stars_icon(50) == "⭐"
    assert Helpers.List.get_stars_icon(1509) == "🌟"
  end

  test "should format category title to id" do
    assert Helpers.List.title_to_id("this is title") == "this-is-title"
    assert Helpers.List.title_to_id("THIS is title") == "this-is-title"
    assert Helpers.List.title_to_id("") == ""
  end
end
