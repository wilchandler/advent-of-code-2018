defmodule AdventOfCode.Day07Test do
  use ExUnit.Case
  doctest AdventOfCode.Day07

  alias AdventOfCode.Day07

  def load_steps_from_file(path) do
    File.read!(path)
    |> String.split("\n")
  end

  describe "sort_steps" do
    # @tag :skip
    test "can solve for the example inputs" do
      inputs = [
        "Step C must be finished before step A can begin.",
        "Step C must be finished before step F can begin.",
        "Step A must be finished before step B can begin.",
        "Step A must be finished before step D can begin.",
        "Step B must be finished before step E can begin.",
        "Step D must be finished before step E can begin.",
        "Step F must be finished before step E can begin."
      ]

      assert Day07.sort_steps(inputs) == "CABDFE"
    end

    # @tag :skip
    test "can solve for the puzzle inputs" do
      inputs = load_steps_from_file("./data/puzzle_inputs.txt")

      assert Day07.sort_steps(inputs) == "GLMVWXZDKOUCEJRHFAPITSBQNY"
    end
  end

end
