defmodule Bob do
  def hey(input) do
    input_trim = String.trim(input)
    cond do
      silence?(input_trim) ->
        "Fine. Be that way!"
      shouting?(input_trim) &&  question?(input_trim) ->
        "Calm down, I know what I'm doing!"
      shouting?(input_trim) ->
        "Whoa, chill out!"
      question?(input_trim) ->
        "Sure."
      true ->
        "Whatever."
    end
  end

  defp silence?(input), do: input == ""
  defp shouting?(input), do: String.upcase(input) == input and String.match?(input, ~r/\p{L}/)
  defp question?(input), do: String.last(input) == "?"
end
