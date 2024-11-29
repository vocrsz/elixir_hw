defmodule Hw6Test do
  use ExUnit.Case, async: true
  doctest Hw6

  alias Hw6.{Repo,User,Post,Comment}
  import Ecto.Query

  setup do
    # Ecto.Adapters.SQL.query!(Hw6.Repo, "DELETE FROM users")
    # Ecto.Adapters.SQL.query!(Hw6.Repo, "DELETE FROM posts")
    # Ecto.Adapters.SQL.query!(Hw6.Repo, "DELETE FROM comments")

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "greets the world" do
    user_author = Repo.insert!(%User{full_name: "author", email: "author@world.ru"})
    assert is_integer(user_author.id)

    user_commenter = Repo.insert!(%User{full_name: "commenter", email: "commenter@world.ru"})
    assert is_integer(user_commenter.id)

    for i <- 1..5 do
      post = Repo.insert!(
        %Post{title: "post #{i}", body: "Lorem ipsum #{i}", user_id: user_author.id}
      )

      for j <- 1..5 do
        Repo.insert!(
          %Comment{user_id: user_commenter.id, post_id: post.id, body: "#{j}. Nice post #{i}"}
        )
      end
    end

    assert Repo.aggregate(User, :count, :id) == 2
    assert Repo.aggregate(Post, :count, :id) == 5
    assert Repo.aggregate(Comment, :count, :id) == 25

    from(u in User, where: u.id == ^user_commenter.id) |> Repo.delete_all()

    assert Repo.aggregate(User, :count, :id) == 1
    assert Repo.aggregate(Post, :count, :id) == 5
    assert Repo.aggregate(Comment, :count, :id) == 25

    from(u in User, where: u.id == ^user_author.id) |> Repo.delete_all()

    assert Repo.aggregate(User, :count, :id) == 0
    assert Repo.aggregate(Post, :count, :id) == 0
    assert Repo.aggregate(Comment, :count, :id) == 0
  end
end
