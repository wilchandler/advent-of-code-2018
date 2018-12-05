defmodule AdventOfCode.Day03.ClaimTest do
  use ExUnit.Case
  doctest AdventOfCode.Day03.Claim

  alias AdventOfCode.Day03.Claim

  test "can be built from a raw string" do
    string = "#1 @ 387,801: 11x22"
    claim = Claim.from_string(string)

    assert claim == %Claim{
      id: 1,
      x: 387,
      y: 801,
      width: 11,
      height: 22
    }
  end

end
