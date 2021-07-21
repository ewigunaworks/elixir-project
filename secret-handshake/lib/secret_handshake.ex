defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @codes %{
    1 => "wink",
    2 => "double wink",
    4 => "close your eyes",
    8 => "jump"
  }
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    events = for{key, val} <- @codes, (code &&& key) > 0, do: val
    if (code &&& 16) > 0, do: events |> Enum.reverse(), else: events
  end
end
