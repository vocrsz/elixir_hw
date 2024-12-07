defmodule Hw2.WithGenServerTest do
  @moduledoc false

  use ExUnit.Case
  doctest Hw2.WithGenServer

  alias Hw2.WithGenServer

  test "sync_ping" do
    {:ok, _} = WithGenServer.start_link()

    result = WithGenServer.sync_ping()

    assert result == :pong
  end

  test "sync_pong" do
    {:ok, _} = WithGenServer.start_link()

    WithGenServer.async_ping()

    assert_receive :pong
  end

  test "get_state" do
    {:ok, _} = WithGenServer.start_link()

    [sync: sync, async: async] = WithGenServer.get_state()
    assert [sync: sync, async: async] == [sync: 0, async: 0]

    WithGenServer.async_ping()

    [sync: sync, async: async] = WithGenServer.get_state()
    assert [sync: sync, async: async] == [sync: 0, async: 1]

    WithGenServer.sync_ping()

    [sync: sync, async: async] = WithGenServer.get_state()
    assert [sync: sync, async: async] == [sync: 1, async: 1]
  end
end
