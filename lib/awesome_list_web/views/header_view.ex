defmodule AwesomeListWeb.HeaderView do
  use AwesomeListWeb, :view
  alias AwesomeListWeb.Helpers

  @stars [0, 10, 50, 100, 500, 1000]

  def get_min_stars() do
    @stars
  end

  def min_stars_link(conn, 0) do
    link("All", to: Routes.list_path(conn, :index ))
  end

  def min_stars_link(conn, min_stars) do
    icon = min_stars |> Helpers.List.get_stars_icon
    link("≥#{min_stars}#{icon}", to: "#{Routes.list_path(conn, :index)}?min_stars=#{min_stars}")
  end

end
