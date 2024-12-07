defmodule Hw4.Trolley do
  use GenServer

  @moduledoc """
  Documentation for `Hw4.Trolley`.
  """

  @transitions %{
    :turned_off => [:under_check_up, :idle],
    :idle => [:moving, :turned_off],
    :moving => [:idle, :broken],
    :under_check_up => [:broken, :turned_off],
    :broken => [:under_repair],
    :under_repair => [:turned_off]
  }

  @impl GenServer
  def init(_), do: {:ok, :turned_off}

  @impl GenServer
  def handle_call(%{state: new_state}, _, current_state) do
    if new_state in @transitions[current_state] do
      success(new_state)
    else
      {:reply, {:error, "transition from :#{current_state} to :#{new_state} is not allowed"}, current_state}
    end
  end

  def handle_call(:get_state, _, state), do: {:reply, {:ok, state}, state}

  defp success(state) do
    {:reply, {:ok, state}, state}
  end
end
