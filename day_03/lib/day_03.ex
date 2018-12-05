defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Day03.Claim

  def part_one(claims) do
    build_piece(claims)
    |> apply_claims(claims)
    |> count_overlapping_claims
  end

  defp build_piece(claims) do
    x_size = Enum.map(claims, &(Claim.x_size(&1))) |> Enum.max
    y_size = Enum.map(claims, &(Claim.y_size(&1))) |> Enum.max
    rows = for _ <- (1..y_size), into: [] do
      row_list = for _ <- (1..x_size), into: [], do: 0
      List.to_tuple(row_list)
    end
    List.to_tuple(rows)
  end

  def apply_claims(piece, claims) do
    Enum.reduce(claims, piece, fn(claim, acc) ->
      apply_claim(acc, claim)
    end)
  end

  def apply_claim(piece, claim) do
    Enum.reduce(1..(claim.height), piece, fn(y, acc) ->
      row_pos = (y + claim.y - 1)
      Enum.reduce(1..(claim.width), acc, fn(x, acc2) ->
        col_pos = (x + claim.x - 1)
        row = elem(acc2, row_pos)
        value = elem(row, col_pos)
        new_row = put_elem(row, col_pos, value + 1)
        put_elem(acc2, row_pos, new_row)
      end)
    end)
  end

  def count_overlapping_claims(piece) do
    Tuple.to_list(piece)
    |> Enum.reduce(0, fn(row, acc) ->
         row_count = Tuple.to_list(row)
                     |> Enum.count(&(&1 > 1))
         acc + row_count
       end)
  end
end
