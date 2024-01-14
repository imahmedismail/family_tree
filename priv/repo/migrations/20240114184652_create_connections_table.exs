defmodule FamilyTree.Repo.Migrations.CreateConnectionsTable do
  use Ecto.Migration

  def up do
    create table(:connections) do
      add :individual_id, references(:individuals, on_delete: :delete_all), null: false
      add :related_individual_id, references(:individuals, on_delete: :delete_all), null: false
      add :relationship_id, references(:relationships, on_delete: :delete_all), null: false
      timestamps()
    end

    create unique_index(:connections, [:individual_id, :related_individual_id, :relationship_id])
  end

  def down do
    drop table(:connections)
  end
end
