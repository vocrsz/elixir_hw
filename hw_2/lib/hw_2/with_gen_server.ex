defmodule Hw2.WithGenServer do
  @moduledoc false

  use GenServer

  @spec start_link() :: {:ok, pid()}
  def start_link() do
    GenServer.start_link(__MODULE__, [sync: 0, async: 0], name: __MODULE__)
  end

  @spec sync_ping() :: :pong
  def sync_ping() do
    GenServer.call(__MODULE__, :ping)
  end

  @spec async_ping() :: :ok
  def async_ping() do
    GenServer.cast(__MODULE__, {:ping, self()})
  end

  @spec get_state() :: [sync: integer(), async: integer()]
  def get_state() do
    GenServer.call(__MODULE__, :state)
  end

  # Server (GenServer) callbacks

  @impl true
  def init(initial_value) do
    {:ok, initial_value}
  end

  @impl true
  def handle_call(:ping, _from, state) do
    new_state = Keyword.update!(state, :sync, &(&1 + 1))
    {:reply, :pong, new_state}
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:ping, sender_pid}, state) do
    new_state = Keyword.update!(state, :async, &(&1 + 1))

    send(sender_pid, :pong)

    {:noreply, new_state}
  end
end
