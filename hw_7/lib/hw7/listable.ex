defprotocol Hw7.Listable do
  @spec to_list(any()) :: Hw7.List.t()
  def to_list(input)

  @spec print(Hw7.List.t()) :: String.t()
  def print(list)
end

defimpl Hw7.Listable, for: BitString do
  @spec to_list(String.t()) :: list(String.t())
  def to_list(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(%Hw7.List{}, fn item, list -> %Hw7.List{items: list.items ++ [item]} end)
  end

  @spec print(String.t()) :: String.t()
  def print(input) do
    input
    |> to_list()
    |> Hw7.BulletList.print()
  end
end

defimpl Hw7.Listable, for: Integer do
  @spec to_list(Integer.t()) :: list(String.t())
  def to_list(input) do
    input
    |> to_string()
    |> String.graphemes()
    |> Enum.reduce(%Hw7.List{}, fn item, list -> %Hw7.List{items: list.items ++ [item]} end)
  end

  @spec print(Integer.t()) :: String.t()
  def print(input) do
    input
    |> to_list()
    |> Hw7.NumberList.print()
  end
end
