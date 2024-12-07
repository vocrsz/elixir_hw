defmodule Hw2.WithReceiver do
  @moduledoc false

  @spec start() :: pid()
  def start do
    spawn(fn -> pong() end)
  end

  @spec pong() :: nil
  defp pong() do
    receive do
      {:ping, machine_pid} ->
        send(machine_pid, :pong)
        pong()

      :stop ->
        nil

      _ ->
        pong()
    end
  end
end
