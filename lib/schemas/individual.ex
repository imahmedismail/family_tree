defmodule Schemas.Individual do
  use Ecto.Schema
  import Ecto.Changeset

  schema "individuals" do
    field(:name, :string)
    timestamps()
  end

  def changeset(individual, attrs \\ %{}) do
    individual
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_format(:name, ~r/\A[a-zA-Z\s]+\z/,
      message: "should contain only letters and spaces"
    )
    |> unique_constraint(:name,
      name: "individuals_name_index",
      message: "Individual already exists"
    )
  end
end
