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

  def part_two(inputs) do
    part_two(inputs, 0, MapSet.new([0]))
  end

  defp part_two([head | tail], acc, previous_values) do
    value = part_one([head], acc)
    if MapSet.member?(previous_values, value) do
      value
    else
      new_set = MapSet.put(previous_values, value)
      part_two(tail ++ [head], value, new_set)
    end
  end
end
