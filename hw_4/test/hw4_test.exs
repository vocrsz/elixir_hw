defmodule Hw4Test do
  use ExUnit.Case
  doctest Hw4

  setup do
    {:ok, pid} = Hw4.start_link()
    {:ok, pid: pid}
  end

  describe "#get_state" do
    test "returns :turned_off by default" do
      assert Hw4.get_state() == :turned_off
    end
  end

  describe "#make_idle" do
    test "allows transition from @turned_off to @idle state" do
      Hw4.make_transition(:idle)
      assert Hw4.get_state() == :idle
    end

    test "doesn't allow transition from @under_check_up to @idle state" do
      Hw4.make_transition(:under_check_up)
      assert Hw4.get_state() == :under_check_up

      assert_raise ArgumentError, "transition from :under_check_up to :idle is not allowed", fn ->
        Hw4.make_transition(:idle)
      end

      assert Hw4.get_state() == :under_check_up
    end
  end

  describe "long success flow" do
    test "it works" do
      s0 = Hw4.get_state()

      with s1 <- Hw4.make_transition(:idle),
           s2 <- Hw4.make_transition(:moving),
           s3 <- Hw4.make_transition(:idle),
           s4 <- Hw4.make_transition(:turned_off),
           s5 <- Hw4.make_transition(:under_check_up),
           s6 <- Hw4.make_transition(:broken),
           s7 <- Hw4.make_transition(:under_repair),
           s8 <- Hw4.make_transition(:turned_off) do
        assert [
                 :turned_off,
                 :idle,
                 :moving,
                 :idle,
                 :turned_off,
                 :under_check_up,
                 :broken,
                 :under_repair,
                 :turned_off
               ] == [s0, s1, s2, s3, s4, s5, s6, s7, s8]
      end
    end
  end
end
