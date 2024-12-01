defmodule Hw7.List do
  @type t() :: %__MODULE__{
    items: list(String.t())
  }

  @callback print(t()) :: String.t()

  defstruct [items: []]
end

defmodule Hw7.BulletList do
  @behaviour Hw7.List
  @icon "•"

  @impl Hw7.List
  def print(l) do
    l.items
    |> Enum.map(fn(string) -> @icon <> " " <> string end)
    |> Enum.join("\n")
  end
end

defmodule Hw7.NumberList do
  @behaviour Hw7.List

  @impl Hw7.List
  def print(l) do
    l.items
    |> Enum.with_index()
    |> Enum.map(fn {i, idx} -> {i, idx+1} end)
    |> Enum.map(&next_item(&1))
    |> Enum.join("\n")
  end

  defp next_item({item, index}) do
    "#{index}) #{item}"
  end
end
