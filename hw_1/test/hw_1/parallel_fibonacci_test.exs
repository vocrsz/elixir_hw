defmodule Hw1.ParallelFibonacciTest do
  @moduledoc false

  use ExUnit.Case
  doctest ParallelFibonacci

  test "it works" do
    assert ParallelFibonacci.fib(100) == 354_224_848_179_261_915_075
  end

  test "it corresponds with neighbour values" do
    assert ParallelFibonacci.fib(100) ==
             assert(ParallelFibonacci.fib(99) + assert(ParallelFibonacci.fib(98)))
  end

  test "it works fast enought" do
    start_time = System.monotonic_time()
    assert ParallelFibonacci.fib(10_000)
    end_time = System.monotonic_time()

    elapsed_time = System.convert_time_unit(end_time - start_time, :native, :millisecond)

    assert elapsed_time <= 4000
  end
end
