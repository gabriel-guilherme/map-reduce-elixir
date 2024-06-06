defmodule App do
  def getRepositorio(arquivo) do
    ES.lerArquivo(arquivo)
  end

  def mapConcorrente(particao, funcaoMap) do
    Task.async(Enum, :map, [particao, funcaoMap])
  end

  def reduceConcorrente(particao, funcaoReduce) do
    Task.async(NossoReduce, :reduce, [particao, funcaoReduce])
  end

  def agrupar(particoes) do
    List.flatten(particoes)
    |> Enum.group_by(fn {key, _} -> key end, fn {_, valor} -> valor end)
    |> Map.to_list
  end

  def executar(input, qtdparticoes, funcaoMap, funcaoReduce) do
    getRepositorio(input)
    |> Particao.particionar(qtdparticoes)
    |> Enum.map(fn particao -> mapConcorrente(particao, funcaoMap) end)
    |> Task.await_many()
    |> agrupar
    |> Particao.particionar(qtdparticoes)
    |> Enum.map(fn particao -> reduceConcorrente(particao, funcaoReduce) end)
    |> Task.await_many()
    |> List.flatten()
  end

  def demo(input, qtdparticoes) do
    executar(input, qtdparticoes, &Usuario.map/1, &Usuario.reduce/2)
  end

  def demo(qtdparticoes) do
    executar("sherk.txt", qtdparticoes, &Usuario.map/1, &Usuario.reduce/2)
  end
end
