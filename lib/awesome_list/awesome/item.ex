defmodule AwesomeList.Awesome.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "awesome_items" do
    field :description, :string
    field :last_commit, :naive_datetime
    field :stars, :integer
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :description, :url, :stars, :last_commit])
    |> validate_required([:title, :description, :url, :stars, :last_commit])
  end
end
