defmodule AwesomeList.MdParser do
  alias AwesomeList.AstHelper

  @section_tag  "\n# "
  @category_tag "\n## "
  @selector "li"

  def parse(body) do
    body
      |> get_categories
      |> parse_categories
  end

  defp get_categories(raw_markdown) do
    raw_markdown
      |> clean_markup
  end

  defp clean_markup(markdown) do
    markdown
      |> String.split(@section_tag, trim: true)
      |> List.first()
      |> String.split(@category_tag, trim: true)
      |> List.delete_at(0)
  end

  defp parse_categories(category_list) do
    category_list
      |> Task.async_stream(&get_data_from_category(&1))
      |> stream_to_list
  end

  defp get_data_from_category(category_raw_string) do
    [title, description | raw_repos ] = category_raw_string
      |> String.split("\n", trim: true)

    { title, parse_description(description), parse_repos(raw_repos) }
  end

  defp parse_description(description) do
    description
      |> String.replace("*", "")
  end

  defp parse_repos(raw_repos) do
    raw_repos
      |> Task.async_stream(&parse_repo(&1))
      |> stream_to_list
  end

  defp parse_repo(repo_data_string) do
    repo_data_string
      |> Earmark.as_ast
      |> get_repo_data_from_ast
  end

  defp stream_to_list(stream) do
    stream
      |> Enum.reduce([], fn { :ok, item }, acc -> [ item | acc ] end)
  end

  defp get_repo_data_from_ast({ :ok, ast, _ }) do
    ast
      |> AstHelper.find_node(@selector)
      |> extract_repo_data
  end

  defp get_repo_data_from_ast(_) do
    raise "Error while parsing md -> ast"
  end

  defp extract_repo_data({ _, _, childs }) do
    [ { _, [{ _, url }], [ repo_name ]} | rest ] = childs

    description = rest
    |> Earmark.Transform.transform(%{ smartypants: true })
    |> String.replace("\n", "")

    %{
      link: { repo_name, url },
      description: description
    }
  end

  defp extract_repo_data(nil) do
    raise "Node is not exist"
  end

end
