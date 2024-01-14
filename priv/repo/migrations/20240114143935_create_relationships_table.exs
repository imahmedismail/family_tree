defmodule FamilyTree.Repo.Migrations.CreateRelationsTable do
  use Ecto.Migration

  def up do
    create table(:relationships) do
      add :relationship_type, :string, null: false
      timestamps()
    end

    create unique_index(:relationships, [:relationship_type])
  end

  def down do
    drop table(:relationships)
  end
end
