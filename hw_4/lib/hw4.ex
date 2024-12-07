defmodule Hw4 do
  @moduledoc """
  Documentation for `Hw4`.
  """

  alias Hw4.Trolley

  @spec start_link() :: {:ok, pid()}
  def start_link, do: GenServer.start_link(Trolley, nil, name: Trolley)

  @spec make_transition(state :: atom()) :: {:ok, atom()}
  def make_transition(state) do
    case GenServer.call(Trolley, %{state: state}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  @spec get_state() :: {:ok, atom()}
  def get_state do
    case GenServer.call(Trolley, :get_state) do
      {:ok, state} -> state
      {:error, message} -> raise ArgumentError, message
    end
  end
end
