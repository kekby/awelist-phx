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

  test "should return outdated class from repo item" do
    now = Date.utc_today()
    outdated_date = Date.add(now, -400)
    fresh_date = Date.add(now, -100)

    assert Helpers.List.get_repo_item_attributes(%{last_updated: outdated_date }) == "class=outdated"
    assert Helpers.List.get_repo_item_attributes(%{last_updated: fresh_date }) == ""
  end
end
