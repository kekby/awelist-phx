defmodule AwesomeList.StorageTest do
  use ExUnit.Case
  use AwesomeList.DataCase
  alias AwesomeList.{Storage}

  @category_keys [:title, :description, :repos]

  @raw_list [
    {"YAML", "Libraries and implementations working with YAML.",
     [
       %{
         description: " - libyaml interface for Elixir.",
         name: "yomel",
         repo: %{last_updated: "2016-01-11T14:47:53Z", stars: 6},
         url: "https://github.com/Joe-noh/yomel"
       },
       %{
         description: " - Yaml parser for Elixir based on native Erlang implementation.",
         name: "yaml_elixir",
         repo: %{last_updated: "2019-05-19T18:35:57Z", stars: 100},
         url: "https://github.com/KamilLelonek/yaml-elixir"
       }
     ]},
    {"XML",
     "Libraries and implementations working with XML (for html tools please go to the [HTML](#html) section).",
     [
       %{
         description: " - Library for encoding and decoding XML-RPC for clients and servers.",
         name: "xmlrpc",
         repo: %{last_updated: "2019-09-03T16:55:05Z", stars: 28},
         url: "https://github.com/ewildgoose/elixir-xml_rpc"
       },
       %{
         description: " - Elixir library for generating xml.",
         name: "xml_builder",
         repo: %{last_updated: "2019-11-09T07:26:04Z", stars: 111},
         url: "https://github.com/joshnuss/xml_builder"
       }
     ]}
  ]

  setup do
    {:ok, items} = Storage.save_list(@raw_list)
    %{items: items}
  end

  test "should return items from database" do
    categories = Storage.get_list()
    assert length(categories) == 2

    for cat <- categories, key <- @category_keys do
      assert Map.has_key?(cat, key)
    end
  end

  test "should return items with more than specified stars count" do
    stars = 50
    categories = Storage.get_list(50)

    awesome_items =
      categories
      |> Enum.map(fn %{repos: repos} -> repos end)
      |> List.flatten()

    for item <- awesome_items do
      assert item.stars >= stars
    end
  end

  test "should return categories in correct order (sorted by title)" do
    categories_titles =
      Storage.get_list()
      |> Enum.map(fn c -> c.title end)

    assert categories_titles == ["XML", "YAML"]
  end

  test "should return awesome items in correct order (sorted by title)" do
    categories =
      Storage.get_list()
      |> Enum.map(fn %{title: title, repos: repos} -> %{ title: title, repos: repos |> Enum.map(fn r -> r.title end) } end)

    assert categories == [
      %{title: "XML", repos: ["xml_builder", "xmlrpc"] },
      %{title: "YAML", repos: ["yaml_elixir", "yomel"] }
    ]
  end
end
