defmodule AwesomeList.Awesome.Item do
  use Ecto.Schema
  alias AwesomeList.Awesome.Category
  import Ecto.Changeset

  schema "awesome_items" do
    field :title, :string
    field :description, :string
    field :last_updated, :naive_datetime
    field :stars, :integer
    field :url, :string
    belongs_to :category, Category
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :description, :url, :stars, :last_updated, :category])
    |> validate_required([:title, :description, :url, :stars, :last_updated, :category])
  end
end
