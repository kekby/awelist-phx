defmodule AwesomeListWeb.ListController do
  use AwesomeListWeb, :controller

  def index(%{ query_params: %{ "min_stars" => stars } } = conn, _params) do
    render_page(conn, Integer.parse(stars))
  end

  def index(conn, _params) do
    render_page(conn)
  end

  def render_page(conn, { stars, _ }) do
    render(conn, "index.html", stars: stars)
  end

  def render_page(conn, :error) do
    render(conn, "index.html")
  end

  def render_page(conn) do
    render(conn, "index.html")
  end
end
