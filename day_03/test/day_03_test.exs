defmodule AdventOfCode.Day03Test do
  use ExUnit.Case
  doctest AdventOfCode.Day03

  alias AdventOfCode.Day03
  alias AdventOfCode.Day03.Claim

  def load_claims_from_file(path) do
    File.read!(path)
    |> String.split("\n")
  end

  def strings_to_claims(strings) do
    Enum.map(strings, &(Claim.from_string(&1)))
  end

  describe "overlapping_inches" do
    test "solves the example inputs" do
      raw_claims = [
        "#1 @ 1,3: 4x4",
        "#2 @ 3,1: 4x4",
        "#3 @ 5,5: 2x2"
      ]
      claims = strings_to_claims(raw_claims)

      assert Day03.overlapping_inches(claims) == 4
    end

    # @tag :skip
    test "solves the puzzle inputs" do
      claims =
        load_claims_from_file("./data/part_one_inputs.txt")
        |> strings_to_claims

      assert Day03.overlapping_inches(claims) == 115304
    end
  end

  describe "independent_claims" do
    test "solves the example inputs" do
      raw_claims = [
        "#1 @ 1,3: 4x4",
        "#2 @ 3,1: 4x4",
        "#3 @ 5,5: 2x2"
      ]
      claims = strings_to_claims(raw_claims)

      assert Day03.independent_claims(claims) == [3]
    end

    # @tag :skip
    test "solves the puzzle inputs" do
      claims =
        load_claims_from_file("./data/part_one_inputs.txt")
        |> strings_to_claims

      assert Day03.independent_claims(claims) == [3]
    end
  end
end
