defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  @directions [:north, :east, :south, :west]
  @directions_length length(@directions)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    valid_direction = Enum.member?(@directions, direction)

    valid_position = match?({x, y} when is_integer(x) and is_integer(y), position)

    cond do
      valid_direction && valid_position ->
        %RobotSimulator{direction: direction, position: position}

      !valid_direction ->
        {:error, "invalid direction"}

      !valid_position ->
        {:error, "invalid position"}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    result =
      instructions
      |> String.graphemes()
      |> Enum.reduce_while(robot, fn instruction,
                                     %RobotSimulator{direction: direction, position: {x, y}} ->
        case instruction do
          "R" ->
            new_direction = turn(direction, +1)
            {:cont, %RobotSimulator{direction: new_direction, position: {x, y}}}

          "L" ->
            new_direction = turn(direction, -1)
            {:cont, %RobotSimulator{direction: new_direction, position: {x, y}}}

          "A" ->
            new_position =
              case direction do
                :north -> {x, y + 1}
                :east -> {x + 1, y}
                :south -> {x, y - 1}
                :west -> {x - 1, y}
              end

            {:cont, %RobotSimulator{direction: direction, position: new_position}}

          _ ->
            {:halt, "invalid instruction"}
        end
      end)

    case result do
      %RobotSimulator{} = r -> r
      error -> {:error, error}
    end
  end

  def turn(direction, rotation) do
    current_index =
      Enum.find_index(@directions, fn current_direction -> current_direction == direction end)

    Enum.fetch!(@directions, rem(current_index + rotation, @directions_length))
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
