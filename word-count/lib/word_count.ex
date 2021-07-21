defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @regex_rule ~r{[^[:alnum:]\-]}u

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(@regex_rule, trim: true)
    |> Enum.frequencies()
  end
end
