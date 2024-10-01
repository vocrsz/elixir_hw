defmodule WithReceiver do
  def start do
    spawn(fn -> pong() end)
  end

  defp pong do
    receive do
      {:ping, machine_pid} ->
        send(machine_pid, :pong)
        pong()
      :stop -> nil
      _ -> pong()
    end
  end
end
