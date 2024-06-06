defmodule Particao do
def particionar(repositorio, qtdparticoes) when length(repositorio) < qtdparticoes, do: particionar(repositorio, length(repositorio) )

# Dá para dividir o repositório em partições iguais
def particionar(repositorio, qtdparticoes) when length(repositorio)|> rem(qtdparticoes) == 0 do
  Enum.chunk_every(repositorio, div(length(repositorio), qtdparticoes))
end

def particionar(repositorio, qtdparticoes) do
  tamanhoLista = length(repositorio)
  # quantidade de elementos que deve haver em cada partição
  qtdelementos = div(tamanhoLista, qtdparticoes)

  # quantidade de elementos que ficariam sobrando em uma divisão exata de elementos por partição
  rem(tamanhoLista, qtdparticoes)
  # calcula até onde vai a última partição que terá elemento extra do resto
  |> Kernel.*(qtdelementos+1)
  # gera duas listas, uma com os elementos das partições que terão um elemento extra cada,
  # uma com os elementos das partições que não terão um elemento extra
  |> (& (Enum.split(repositorio,&1)) ).()
  # "corta" as partições de ambas as listas e as une em uma única lista
  |> then(fn {parteComRestos, parteSemRestos} -> 
    Enum.chunk_every(parteComRestos, qtdelementos+1) 
    ++ Enum.chunk_every(parteSemRestos, qtdelementos)
    end)
end

end
