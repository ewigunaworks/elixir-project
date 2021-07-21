defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @error_msg "cannot change"

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_coins, target) when target < 0, do: {:error, @error_msg}
  def generate(_coins, 0), do: {:ok, []}

  def generate(coins, target) do
    changes = 1..target
      |> Enum.reduce(%{0 => []}, &(change_for(&1, &2, coins)))
    case Map.get(changes, target) do
      nil    -> {:error, @error_msg}
      change -> {:ok, change}
    end
  end

  def change_for(target, accumulator, coins) do
    change = coins
      |> Enum.filter(&(accumulator[target - &1]))
      |> Enum.map(&([&1 | accumulator[target - &1]]))
      |> IO.inspect()
      |> Enum.min_by(&length/1, fn -> nil end)
      |> IO.inspect()
    Map.put(accumulator, target, change)
  end
end
