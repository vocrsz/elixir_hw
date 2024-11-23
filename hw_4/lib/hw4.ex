defmodule Hw4 do
  @moduledoc """
  Documentation for `Hw4`.
  """

  def start_link, do: GenServer.start_link(Trolley, nil, name: Trolley)

  def make_moving do
    case GenServer.call(Trolley, %{state: :moving}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  def make_idle do
    case GenServer.call(Trolley, %{state: :idle}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  def make_turned_off do
    case GenServer.call(Trolley, %{state: :turned_off}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  def make_broken do
    case GenServer.call(Trolley, %{state: :broken}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  def make_under_repair do
    case GenServer.call(Trolley, %{state: :under_repair}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  def make_under_check_up do
    case GenServer.call(Trolley, %{state: :under_check_up}) do
      {:ok, new_state} -> new_state
      {:error, message} -> raise ArgumentError, message
    end
  end

  def get_state do
    case GenServer.call(Trolley, :get_state) do
      {:ok, state} -> state
      {:error, message} -> raise ArgumentError, message
    end
  end
end
