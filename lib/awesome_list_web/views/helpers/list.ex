defmodule AwesomeListWeb.Helpers.List do
  def get_stars_icon(stars) when stars >= 1000 do
    "🌟"
  end

  def get_stars_icon(_) do
    "⭐"
  end

  def get_days_from_last_update(date) do
    Date.diff(Date.utc_today(), date)
  end

  def title_to_id(string) do
    ~w"#{string}" |> Enum.join("-") |> String.downcase
  end

  def get_repo_item_attributes(item) do
    days = get_days_from_last_update(item.last_updated)
    if days > 365 do
      "class=\"outdated\""
    else
      ""      
    end
  end

end
