defmodule AdventOfCode.Day07 do
  @input_step_regex ~r/(?<=step )[A-Z]/i

  def sort_steps(inputs) do
    Enum.map(inputs, &(parse_input(&1)))
    |> map_dependencies
    |> map_independent_steps
    |> dependencies_map_to_sorted_list
    |> resolve_steps_order
    |> List.to_string
  end

  defp parse_input(input) do
    Regex.scan(@input_step_regex, input)
    |> List.flatten
    |> List.to_tuple
  end

  defp dependencies_map_to_sorted_list(map) do
    Map.to_list(map)
    |> List.keysort(0)
  end

  defp map_dependencies(dependencies), do: map_dependencies(dependencies, %{})
  defp map_dependencies([], map), do: map
  defp map_dependencies([pair | tail], map) do
    map = add_dependency_to_map(map, pair)
    map_dependencies(tail, map)
  end

  defp add_dependency_to_map(map,{dependency, dependent}) do
    Map.update(map, dependent, MapSet.new([dependency]), fn(set) ->
      MapSet.put(set, dependency)
    end)
  end

  defp map_independent_steps(deps) do
    steps = filter_independent_steps(deps)
    add_independent_steps_to_deps(deps, steps)
  end

  defp add_independent_steps_to_deps(deps, []), do: deps
  defp add_independent_steps_to_deps(deps, [head | tail]) do
    Map.put(deps, head, %MapSet{})
    |> add_independent_steps_to_deps(tail)
  end

  defp filter_independent_steps(deps) do
    init_accs = {%MapSet{}, %MapSet{}}
    {dependents, dependencies} = Enum.reduce(deps, init_accs, fn(dep, accs) ->
      dependent = elem(dep, 0)
      dependents = elem(accs, 0) |> MapSet.put(dependent)
      dependencies = MapSet.new(elem(dep, 1)) |> MapSet.union(elem(accs, 1))
      {dependents, dependencies}
    end)
    MapSet.difference(dependencies, dependents)
    |> MapSet.to_list
  end

  defp resolve_steps_order(deps) do
    resolve_steps_order(deps, %MapSet{}, [])
  end

  defp resolve_steps_order(deps, resolved, rev_list) do
    next_step = Enum.find(deps, &step_ready?(&1, resolved))
    resolve_ready_step(deps, resolved, rev_list, next_step)
  end

  def resolve_ready_step(_deps, _resolved, rev_list, nil) do
    Enum.reverse(rev_list)
  end

  def resolve_ready_step(deps, resolved, rev_list, {next_step, _}) do
    resolved = MapSet.put(resolved, next_step)
    rev_list = [next_step | rev_list]
    resolve_steps_order(deps, resolved, rev_list)
  end

  def step_ready?({step, dependencies}, resolved) do
    !(step in resolved) && dependencies_resolved?(dependencies, resolved)
  end

  defp dependencies_resolved?(dependencies, resolved) do
    MapSet.subset?(dependencies, resolved)
  end
end
