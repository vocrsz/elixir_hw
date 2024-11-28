defmodule Hw6.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :full_name, :string
    field :email, :string
    has_many :posts, Hw6.Post
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:full_name, :email])
    |> validate_required([:full_name, :email])
  end
end
