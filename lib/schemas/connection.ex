defmodule Schemas.Connection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Schemas.{Individual, Relationship}

  schema "connections" do
    belongs_to(:individual, Individual)
    belongs_to(:related_individual, Individual, foreign_key: :related_individual_id)
    belongs_to(:relationship, Relationship, foreign_key: :relationship_id)
    timestamps()
  end

  def changeset(relationship, attrs \\ %{}) do
    relationship
    |> cast(attrs, [:individual_id, :related_individual_id, :relationship_id])
    |> validate_required([:individual_id, :related_individual_id, :relationship_id])
    |> unique_constraint(:name,
      name: "connections_individual_id_related_individual_id_relationship_id",
      message: "Duplicate data"
    )
  end
end
