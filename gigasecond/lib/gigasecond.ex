defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    %NaiveDateTime{year: year, month: month, day: day, hour: hours, minute: minutes, second: seconds} =
      %NaiveDateTime{
        year: year,
        month: month,
        day: day,
        hour: hours,
        minute: minutes,
        second: seconds
      }
      |> NaiveDateTime.add(Integer.pow(10, 9), :second)

    {{year, month, day}, {hours, minutes, seconds}}
  end
end
