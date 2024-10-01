defmodule ParallelFibonacci do
  @moduledoc """
  Parallel Fibonacci number calculation
  """

  @doc """
  calculating the fibonacci's i-th member

  ## Examples

      iex> ParallelFibonacci.fib(1)
      1

      iex> ParallelFibonacci.fib(2)
      1

      iex> ParallelFibonacci.fib(10)
      55

  """
  def fib(n) do
    start_link()

    fib_parallel(n)
  end

  defp fib_parallel(n) when n < 2, do: n
  defp fib_parallel(n) do
    case Agent.get(__MODULE__, &Map.get(&1, n)) do
      nil ->
        result1 = Task.async(fn -> fib_parallel(n-1) end) |> Task.await()
        result2 = Task.async(fn -> fib_parallel(n-2) end) |> Task.await()

        result = result1 + result2

        Agent.update(__MODULE__, &Map.put(&1, n, result))

        result
      result -> result
    end
  end

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end
end
