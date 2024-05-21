defmodule MapRed do
  def hello do
    :world
  end

  def mapRed(map, red, data, param) do
    a =
      if rem(length(data), param) == 0 do
        div(length(data), param)
      else
        div(length(data) + param - rem(length(data), param), param)
      end

    IO.puts(a)
    threads = Enum.chunk_every(data, a, a, [])
  end
end

defmodule Mapper do
  def map(input) do
    input
    |> String.split()
    |> Enum.map(fn word -> {word, 1} end)
  end
end

defmodule ParallelMapper do
  def map(inputs) do
    inputs
    |> Enum.map(fn input ->
      Task.async(fn -> Mapper.map(input) end)
    end)
    |> Enum.map(&Task.await/1)
    |> List.flatten()
  end
end

defmodule ParallelReducer do
  def reduce(pairs) do
    pairs
    |> Enum.group_by(fn {key, _value} -> key end)
    |> Enum.map(fn {key, values} ->
      Task.async(fn ->
        {key, Enum.reduce(values, 0, fn {_key, value}, acc -> acc + value end)}
      end)
    end)
    |> Enum.map(&Task.await/1)
  end
end

defmodule ParallelMapReduce do
  def execute(inputs) do
    inputs
    |> ParallelMapper.map()

    # |> ParallelReducer.reduce()
  end
end
