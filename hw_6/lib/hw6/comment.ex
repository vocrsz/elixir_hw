defmodule Hw6.Comment do
  use Ecto.Schema

  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :user, Hw6.User
    belongs_to :post, Hw6.Post
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:body, :user_id, :post_id])
    |> validate_required([:body, :user_id, :post_id])
  end
end
