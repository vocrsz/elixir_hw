defmodule Trolley do
  use GenServer
  @moduledoc """
  Documentation for `Trolley`.
  """

  @turned_off :turned_off
  @idle :idle
  @moving :moving
  @broken :broken
  @under_check_up :under_check_up
  @under_repair :under_repair

  @impl GenServer
  def init(_), do: {:ok, @turned_off}

  @impl GenServer
  def handle_call(%{state: @under_check_up} = update, _, @turned_off), do: success(update.state)

  @impl GenServer
  def handle_call(%{state: @moving} = update, _, @idle), do: success(update.state)

  @impl GenServer
  def handle_call(%{state: @idle} = update, _, @turned_off), do: success(update.state)
  def handle_call(%{state: @idle} = update, _, @moving),     do: success(update.state)

  @impl GenServer
  def handle_call(%{state: @broken} = update, _, @moving),          do: success(update.state)
  def handle_call(%{state: @broken} = update, _, @under_check_up),  do: success(update.state)

  @impl GenServer
  def handle_call(%{state: @under_repair} = update, _, @broken), do: success(update.state)

  @impl GenServer
  def handle_call(%{state: @turned_off} = update, _, @idle),           do: success(update.state)
  def handle_call(%{state: @turned_off} = update, _, @under_repair),   do: success(update.state)
  def handle_call(%{state: @turned_off} = update, _, @under_check_up), do: success(update.state)

  def handle_call(:get_state, _, state), do: {:reply, {:ok, state}, state}

  @impl GenServer
  def handle_call(%{state: to}, _, from) do
    {:reply, {:error, "transition from :#{from} to :#{to} is not allowed"}, from}
  end

  defp success(state) do
    {:reply, {:ok, state}, state}
  end
end
