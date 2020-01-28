defmodule AwesomeList.Awesome.Category do
  use Ecto.Schema
  alias AwesomeList.Awesome.Item
  import Ecto.Changeset

  schema "categories" do
    field :description, :string
    field :title, :string
    has_many :repos, Item
    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
    |> unique_constraint(:title)
  end
end
