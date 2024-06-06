defmodule TesteDesempenho do

#  defp mapNaoConcorrente(particao, funcaoMap) do
#    Enum.map(particao, fn elemento -> funcaoMap.(elemento) end )
#  end

#  defp reduceNaoConcorrente(particao, funcaoReduce) do
#    NossoReduce.reduce(particao, funcaoReduce)
#  end

  def executarSync(input, funcaoMap, funcaoReduce) do
    App.getRepositorio(input)
    |> Enum.map(funcaoMap)
    |> Enum.group_by(fn {key, _} -> key end, fn {_, valor} -> valor end)
    |> Map.to_list()
    |> Enum.map(fn {chave, valor} -> funcaoReduce.(chave,valor) end)
  end

  def testarSync(input) do
    executarSync(input, &Usuario.map/1, &Usuario.reduce/2)
  end

  def testarSync() do
    executarSync("sherk.txt", &Usuario.map/1, &Usuario.reduce/2)
  end

# Não há elementos restantes para serem distribuídos, o restante do repositório pode ser dividido em partes iguais.
defp distribuir(repositorio, qtdelementos, 0, _) do
  Enum.chunk_every(repositorio, qtdelementos-1)
end

# Há elementos restantes para distribuir nas primeiras partições
defp distribuir(repositorio, qtdelementos, restos, tamanhoRepositorio) do
  # O primeiro elemento será uma lista com a quantidade de elementos definida e a aplicação recursiva da função ao restante do repositório
  [Enum.take(repositorio,qtdelementos) | Enum.slice(repositorio, qtdelementos..tamanhoRepositorio)|> distribuir(qtdelementos, restos-1, tamanhoRepositorio - qtdelementos)]
end

def particionar(repositorio, qtdparticoes) when length(repositorio) < qtdparticoes, do: particionar(repositorio, length(repositorio) )

# Dá para dividir o repositório em partições iguais
def particionar(repositorio, qtdparticoes) when length(repositorio)|> rem(qtdparticoes) == 0 do
  Enum.chunk_every(repositorio, div(length(repositorio), qtdparticoes))
end

# Não dá pra dividir o repositório em partições iguais
def particionar(repositorio, qtdparticoes) do
  # A quantidade que restaria de elementos vai ser distribuída nas primeiras partições, assim, essas partições terão um elemento a mais
  length(repositorio)
  |> (&(   distribuir(repositorio, div(&1, qtdparticoes) +1, rem(&1,qtdparticoes), &1)  )).()
end

end