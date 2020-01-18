defmodule AwesomeListWeb.ListController do
  use AwesomeListWeb, :controller
  alias AwesomeListWeb.Router

  def redirect_to_main(conn, _) do
    redirect(conn, to: Router.Helpers.list_path(conn, :index))
  end

  def index(%{ query_params: %{ "min_stars" => stars } } = conn, _params) do
    list = get_awesome_list(Integer.parse(stars))
    render(conn, "index.html", list: list)
  end

  def index(conn, _params) do
    list = get_awesome_list()
    render(conn, "index.html", list: list)
  end

  defp get_awesome_list({ stars, _ }) do
    AwesomeList.Storage.get_list(stars)
  end

  defp get_awesome_list() do
    AwesomeList.Storage.get_list
  end

  defp get_awesome_list(:error) do
    AwesomeList.Storage.get_list
  end
end
