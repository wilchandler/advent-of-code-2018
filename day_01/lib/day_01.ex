defmodule AdventOfCode.Day01 do
  def part_one(inputs) do
    part_one(inputs, 0)
  end

  defp part_one([], acc) do
    acc
  end

  defp part_one([head | tail], acc) do
    part_one(tail, acc + head)
  end
end
