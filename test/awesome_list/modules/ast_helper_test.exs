defmodule AwesomeList.AstHelperTest do
  use ExUnit.Case
  alias AwesomeList.AstHelper

  @ast_mock [
    {"ul", [],
     [
       {"li", [],
        [
          {"a", [{"href", "https://github.com/sasa1977/exactor"}], ["exactor"]},
          " - Helpers for easier implementation of actors in Elixir."
        ]},
       {"li", [],
        [
          {"a", [{"href", "https://github.com"}], ["wtf"]},
          " - Wtf generator"
        ]}
     ]}
  ]

  test "should find nodes by node_name" do
    assert [
             {"a", [{"href", "https://github.com/sasa1977/exactor"}], ["exactor"]},
             {"a", [{"href", "https://github.com"}], ["wtf"]}
           ] = AstHelper.find_nodes(@ast_mock, "a")
  end

  test "should return empty list if node is not find" do
    assert [] == AstHelper.find_nodes(@ast_mock, "h1")
  end

  test "should find first single node by node_name" do
    assert {"a", [{"href", "https://github.com/sasa1977/exactor"}], ["exactor"]} =
             AstHelper.find_node(@ast_mock, "a")
  end

  test "should find all node childrens" do
    assert {"li", [],
            [
              {"a", [{"href", "https://github.com/sasa1977/exactor"}], ["exactor"]},
              " - Helpers for easier implementation of actors in Elixir."
            ]} = AstHelper.find_node(@ast_mock, "li")
  end

  test "should return nil if doesnt find single node" do
    assert nil == AstHelper.find_node(@ast_mock, "h1")
  end
end
