defmodule Hw6.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string, null: false
      add :email, :string, null: false
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
