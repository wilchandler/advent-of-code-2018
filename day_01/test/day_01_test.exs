defmodule AdventOfCode.Day01Test do
  use ExUnit.Case
  doctest AdventOfCode.Day01

  def get_inputs_from_file(path) do
    {:ok, raw_string} = File.read(path)

    String.split(raw_string, "\n")
    |> Enum.map(fn str -> String.to_integer(str) end)
  end

  describe "part one" do
    test "first example can be calculated" do
      inputs = [1, -2, 3, 1]

      assert AdventOfCode.Day01.part_one(inputs) == 3
    end

    test "second example can be calculated" do
      inputs = [1, 1, 1]

      assert AdventOfCode.Day01.part_one(inputs) == 3
    end

    test "third example can be calculated" do
      inputs = [1, 1, -2]

      assert AdventOfCode.Day01.part_one(inputs) == 0
    end

    test "fourth example can be calculated" do
      inputs = [-1, -2, -3]

      assert AdventOfCode.Day01.part_one(inputs) == -6
    end

    test "puzzle input can be calculated" do
      inputs = get_inputs_from_file("./data/part_one_puzzle_inputs.txt")

      assert AdventOfCode.Day01.part_one(inputs) == 569
    end
  end
end
