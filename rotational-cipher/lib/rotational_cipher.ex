defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&transform(&1, shift))
    |> List.to_string()
  end

  defp transform(char, shift) when char in ?a..?z, do: rem(char - ?a + shift, 26) +?a
  defp transform(char, shift) when char in ?A..?Z, do: rem(char - ?A + shift, 26) +?A
  defp transform(char, _shift), do: char
end
