defmodule AwesomeList.AstHelper do



  def find_node(ast, search_name) do
    ast
    |> find_nodes(search_name)
    |> List.first
  end

  def find_nodes(ast, search_name) do
    ast
      |> search_node(search_name, [])
  end

  defp search_node(tree, name, acc) do
    tree
      |> Enum.reduce(acc, &check_node(&1, &2, name))
  end

  defp check_node(node = { node_name , _, childs }, acc, name) when node_name == name do
    new_acc = acc ++ [node]
    search_node(childs, name, new_acc)
  end

  defp check_node(node = { node_name , _, childs }, acc, name) do
    search_node(childs, name, acc)
  end

  defp check_node(_, acc, _) do
    acc
  end
end
