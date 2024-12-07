defmodule Hw2.WithReceiverTest do
  @moduledoc false

  use ExUnit.Case
  doctest Hw2.WithReceiver

  alias Hw2.WithReceiver

  test "ping" do
    pong_pid = WithReceiver.start()

    send(pong_pid, {:ping, self()})

    assert_receive(:pong)

    :timer.sleep(100)
    assert Process.alive?(pong_pid)

    send(pong_pid, {:ping, self()})

    assert_receive(:pong)
  end

  test "invalid value" do
    pong_pid = WithReceiver.start()

    send(pong_pid, :invalid_value)

    :timer.sleep(100)
    assert Keyword.get(Process.info(pong_pid), :message_queue_len) == 0

    refute_receive _
  end

  test "stop" do
    pong_pid = WithReceiver.start()

    send(pong_pid, :stop)

    refute_receive _

    :timer.sleep(100)
    refute Process.alive?(pong_pid)
  end
end
