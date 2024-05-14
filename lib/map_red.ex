defmodule MapRed do
  def hello do
    :world
  end

  def mapRed(map, red, data, param) do

    a = if rem(length(data), param) == 0 do
      div(length(data), param)
    else
      div(length(data) + param - rem(length(data), param), param)
    end
    IO.puts(a)
    threads = Enum.chunk_every(data, a, a, [])
  end
end
