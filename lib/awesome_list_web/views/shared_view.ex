defmodule AwesomeListWeb.SharedView do
  use AwesomeListWeb, :view

  def get_min_stars() do
    [0, 10, 50, 100, 500, 1000]
  end

  def min_stars_link(conn, 0) do
    link("All", to: Routes.list_path(conn, :index ))
  end

  def min_stars_link(conn, min_stars) when min_stars >= 1000 do
    link("≥#{min_stars}🌟", to: "#{Routes.list_path(conn, :index)}?min_stars=#{min_stars}")
  end

  def min_stars_link(conn, min_stars) do
    link("≥#{min_stars}⭐", to: "#{Routes.list_path(conn, :index)}?min_stars=#{min_stars}")
  end

end
