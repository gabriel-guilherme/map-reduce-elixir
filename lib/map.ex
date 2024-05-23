defmodule NossoMap do
  def map([], _), do: []

  def map([h | t], funcao) do
    [funcao.(h) | map(t, funcao)]
  end
end
