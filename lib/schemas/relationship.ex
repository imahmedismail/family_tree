defmodule Schemas.Relationship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "relationships" do
    field(:relationship_type, :string)
    timestamps()
  end

  def changeset(relationship, attrs \\ %{}) do
    relationship
    |> cast(attrs, [:relationship_type])
    |> validate_required([:relationship_type])
    |> validate_format(:relationship_type, ~r/\A[a-zA-Z\s]+\z/,
      message: "should contain only letters and spaces"
    )
  end
end
