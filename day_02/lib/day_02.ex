defmodule AdventOfCode.Day02 do
  def generate_checksum(ids_list, counts_list) do
    ids_occurrences = Enum.map(ids_list, fn id -> occurrences_in_id(counts_list, id) end)

    build_checksum_factors(counts_list, ids_occurrences, %{})
    |> Map.values()
    |> Enum.reduce(1, &(&1 * &2))
  end

  def occurrences_in_id(counts_list, string) do
    occurence_counts =
      String.codepoints(string)
      |> count_occurrences

    for count <- counts_list, into: %{} do
      {count, has_count_value?(occurence_counts, count)}
    end
  end

  defp has_count_value?(map, count) do
    Enum.any?(map, fn {_k, v} -> v == count end)
  end

  defp count_occurrences(list) do
    count_occurrences(list, %{})
  end

  defp count_occurrences([], counts), do: counts

  defp count_occurrences([head | tail], counts) do
    current_count = Map.get(counts, head) || 0
    new_counts = Map.put(counts, head, current_count + 1)
    count_occurrences(tail, new_counts)
  end

  defp build_checksum_factors([], _foo, acc), do: acc

  defp build_checksum_factors([head_count | tail_counts], foo, acc) do
    count_for_id = Enum.count(foo, fn bar -> bar[head_count] end)
    new_acc = Map.put(acc, head_count, count_for_id)
    build_checksum_factors(tail_counts, foo, new_acc)
  end
end
