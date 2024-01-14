defmodule FamilyTree.Commands do
  alias FamilyTree.Repo
  alias Schemas.{Individual, Relationship, Connection}
  import Ecto.Query

  def add_person(name) do
    changeset = Individual.changeset(%Individual{}, %{name: name |> Enum.join(" ")})

    case Repo.insert(changeset) do
      {:ok, _person} -> IO.puts("Person added!")
      {:error, _changeset} -> IO.puts("Duplicated name, can't insert a same name twice")
    end
  end

  def add_relation(relationship_type) do
    relationship_type = String.downcase(relationship_type)
    changeset = Relationship.changeset(%Relationship{}, %{relationship_type: relationship_type})

    case Repo.insert(changeset) do
      {:ok, _relationship} -> IO.puts("Relation added!")
      {:error, _changeset} -> IO.puts("Duplicated relation, can't insert a same relation twice")
    end
  end

  def connect_relation(name1, name2, relationship) do
    individual_id = Individual |> Repo.get_by(name: name1) |> Map.get(:id)
    related_individual_id = Individual |> Repo.get_by(name: name2) |> Map.get(:id)
    relationship_id = Relationship |> Repo.get_by(relationship_type: relationship) |> Map.get(:id)

    params = %{
      relationship_id: relationship_id,
      individual_id: individual_id,
      related_individual_id: related_individual_id
    }

    changeset = Connection.changeset(%Connection{}, params)

    case Repo.insert(changeset) do
      {:ok, _relationship} -> IO.puts("Connected 2 individuals!")
      {:error, _changeset} -> IO.puts("Some error occurred!")
    end
  end

  def count(relation, name) do
    relation = if relation == "wive", do: "wife", else: relation
    relationship_id = Relationship |> Repo.get_by(relationship_type: relation) |> Map.get(:id)
    individual_id = Individual |> Repo.get_by(name: name) |> Map.get(:id)

    connections =
      from(c in Connection,
        where: c.relationship_id == ^relationship_id and c.related_individual_id == ^individual_id
      )

    IO.puts(Repo.aggregate(connections, :count))
  end

  def father_of(name) do
    name = name |> Enum.join(" ")
    individual_id = Individual |> Repo.get_by(name: name) |> Map.get(:id)
    relation_id = Relationship |> Repo.get_by(relationship_type: "son") |> Map.get(:id)

    individual_id =
      from(c in Connection,
        where: c.individual_id == ^individual_id and c.relationship_id == ^relation_id
      )
      |> Repo.one()
      |> Map.get(:related_individual_id)

    father_name = Individual |> Repo.get_by(id: individual_id) |> Map.get(:name)
    IO.puts(father_name)
  end
end
