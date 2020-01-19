defmodule AwesomeList.MdParser do

  @category_tag "## "

  def parse(body) do
    body
      |> get_categories
      |> parse_categories
  end

  defp get_categories(raw_markdown) do
    raw_markdown
      |> String.split(@category_tag, trim: true)
      |> List.delete_at(0)
  end

  defp parse_categories(category_list) do
    category_list
      |> Task.async_stream(&get_data_from_category(&1))
      |> Enum.to_list
      |> IO.inspect
  end

  defp get_data_from_category(category_raw_string) do
    [title, description | raw_repos ] = category_raw_string
      |> String.split("\n", trim: true)
    { title, get_description(description), raw_repos }
  end

  defp get_description(description) do
    description
      |> String.replace("*", "")
  end

end
