defmodule Hw7Test do
  use ExUnit.Case
  doctest Hw7

  alias Hw7.{Listable,List,BulletList,NumberList}

  describe "test Listable protocol" do
    test "to_list/1 for BitString" do
      assert Listable.to_list("hello") == %List{items: ["hello"]}

      multiline_string = """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit,
      sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
      Ut enim ad minim veniam, quis nostrud exercitation ullamco
      """

      assert Listable.to_list(multiline_string) == %List{items: [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco"
      ]}
    end

    test "to_list/1 for Integer" do
      assert Listable.to_list(12345) == %List{items: ["1", "2", "3", "4", "5"]}
    end

    test "print/1 for BitString" do
      assert Listable.print("a\nb\nc\nd\ne") == """
      • a
      • b
      • c
      • d
      • e
      """ |> String.trim()
    end

    test "print/1 for Integer" do
      assert Listable.print(12345) == """
      1) 1
      2) 2
      3) 3
      4) 4
      5) 5
      """ |> String.trim()
    end
  end

  describe "test List behaviour" do
    test "BulletList print" do
      list = Listable.to_list(12345)

      assert BulletList.print(list) == """
      • 1
      • 2
      • 3
      • 4
      • 5
      """ |> String.trim()
    end

    test "NumberList print" do
      list = Listable.to_list(12345)

      assert NumberList.print(list) == """
      1) 1
      2) 2
      3) 3
      4) 4
      5) 5
      """ |> String.trim()
    end
  end
end
