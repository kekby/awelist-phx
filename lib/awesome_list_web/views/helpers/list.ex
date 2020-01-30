defmodule AwesomeListWeb.Helpers.List do
  def get_stars_icon(stars) when stars >= 1000 do
    "🌟"
  end

  def get_stars_icon(_) do
    "⭐"
  end

  def title_to_id(string) do
    ~w"#{string}" |> Enum.join("-") |> String.downcase
  end
end
