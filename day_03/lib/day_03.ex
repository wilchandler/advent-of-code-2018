defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Day03.Claim

  require IEx

  def overlapping_inches(claims) do
    build_piece(claims)
    |> apply_claims(claims)
    |> count_overlapping_claims
  end

  def independent_claims(claims) do
    build_piece(claims)
    |> apply_claims(claims)
    |> filter_independent_claims
  end

  defp build_piece(claims) do
    x_size = Enum.map(claims, &(Claim.x_size(&1))) |> Enum.max
    y_size = Enum.map(claims, &(Claim.y_size(&1))) |> Enum.max
    rows = for _ <- (1..y_size), into: [] do
      row_list = for _ <- (1..x_size), into: [], do: []
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
        new_row = put_elem(row, col_pos, [claim.id | value])
        put_elem(acc2, row_pos, new_row)
      end)
    end)
  end

  def count_overlapping_claims(piece) do
    Tuple.to_list(piece)
    |> Enum.reduce(0, fn(row, acc) ->
         row_count = Tuple.to_list(row)
                     |> Enum.count(&(length(&1) > 1))
         acc + row_count
       end)
  end

  defp filter_independent_claims(piece) do
    claims_per_inch =
      Tuple.to_list(piece)
      |> Enum.reduce([], fn(row, acc) ->
        Tuple.to_list(row) ++ acc
      end)

    collect_ids_set(claims_per_inch)
    |> reject_overlapping_claims(claims_per_inch)
    |> MapSet.to_list
  end

  defp collect_ids_set(claims_per_inch) do
    collect_ids_set(%MapSet{}, claims_per_inch)
  end

  defp collect_ids_set(set, []), do: set
  defp collect_ids_set(set, [head_inch | tail]) do
    list_into_set(set, head_inch)
    |> collect_ids_set(tail)
  end

  defp list_into_set(set, []), do: set
  defp list_into_set(set, [head | tail]) do
    MapSet.put(set, head)
    |> list_into_set(tail)
  end

  defp reject_overlapping_claims(set, []), do: set
  defp reject_overlapping_claims(set, [head_inch | tail]) do
    delete_list_elements_from_set(set, head_inch)
    |> reject_overlapping_claims(tail)
  end

  defp delete_list_elements_from_set(set, []), do: set
  defp delete_list_elements_from_set(set, [_ | []]), do: set
  defp delete_list_elements_from_set(set, list) do
    Enum.reduce(list, set, fn(el, acc) -> MapSet.delete(acc, el) end)
  end

end
