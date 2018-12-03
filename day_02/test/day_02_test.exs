defmodule AdventOfCode.Day02Test do
  use ExUnit.Case
  doctest AdventOfCode.Day02

  alias AdventOfCode.Day02

  def load_ids_from_file(path) do
    File.read!(path)
    |> String.split("\n")
  end

  describe "occurrences_in_id" do
    test "returns a map of given counts to booleans" do
      assert Day02.occurrences_in_id([2, 3], "abcdef") == %{2 => false, 3 => false}
      assert Day02.occurrences_in_id([2, 3], "bababc") == %{2 => true, 3 => true}
      assert Day02.occurrences_in_id([2, 3], "abbcde") == %{2 => true, 3 => false}
      assert Day02.occurrences_in_id([2, 3], "abcccd") == %{2 => false, 3 => true}
      assert Day02.occurrences_in_id([2, 3], "aabcdd") == %{2 => true, 3 => false}
      assert Day02.occurrences_in_id([2, 3], "abcdee") == %{2 => true, 3 => false}
      assert Day02.occurrences_in_id([2, 3], "ababab") == %{2 => false, 3 => true}
    end
  end

  describe "generate_checksum" do
    test "can solve the challenge example" do
      ids = [
        "abcdef",
        "bababc",
        "abbcde",
        "abcccd",
        "aabcdd",
        "abcdee",
        "ababab"
      ]

      assert Day02.generate_checksum(ids, [2, 3]) == 12
    end

    test "can solve the part one inputs" do
      ids = load_ids_from_file("./data/part_one_puzzle_inputs.txt")

      assert Day02.generate_checksum(ids, [2, 3]) == 7776
    end
  end
end
