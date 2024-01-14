defmodule FamilyTree.Repo.Migrations.CreateIndividualsTable do
  use Ecto.Migration

  def up do
    create table(:individuals) do
      add :name, :string, null: false
      timestamps()
    end

    create unique_index(:individuals, [:name])
  end

  def down do
    drop table(:individuals)
  end
end
