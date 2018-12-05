defmodule AdventOfCode.Day03.Claim do
  defstruct [:id, :x, :y, :width, :height]

  @string_capture_regex ~r/#(?<id>\d+)\s@\s(?<x>\d+),(?<y>\d+):\s(?<width>\d+)x(?<height>\d+)/

  def from_string(string) do
    fields =
      Regex.named_captures(@string_capture_regex, string)
      |> Enum.map(fn {k,v} -> {String.to_atom(k), String.to_integer(v)} end)
    struct(AdventOfCode.Day03.Claim, fields)
  end

  def x_size(claim) do
    claim.x + claim.width
  end

  def y_size(claim) do
    claim.y + claim.height
  end
end