defmodule Usuario do

  def map(elemento) do
    novoElemento =
      elemento
      |> String.downcase()
      |> String.replace(~r/[^[:alnum:][:space:]\p{L}]/u, "")
    {novoElemento, 1}
  end

  def reduce(chave, lista) do
    {chave, Enum.count(lista)}
  end

end