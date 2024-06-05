defmodule App do
  def getRepositorio() do
    ES.lerArquivo("sherk.txt")
  end

  defp map(particao, funcaoMap) do
    Task.async(NossoMap, :map, [particao, funcaoMap])
  end

  defp reduce(particao, funcaoReduce) do
    Task.async(NossoReduce, :reduce, [particao,funcaoReduce])
  end

  def executar(qtdparticoes, funcaoMap, funcaoReduce) do
    getRepositorio()
    |> Particao.particionar(qtdparticoes)
    |> Enum.map(fn particao -> map(particao,funcaoMap) end )
    # Esperar por uma lista de tasks
    |> Task.await_many()

    |> List.flatten()
    |> Enum.group_by(fn {key, _} -> key end, fn {_, valor} -> valor end)
    |> Map.to_list

    |> Particao.particionar(qtdparticoes)
    |> Enum.map(fn particao -> reduce(particao, funcaoReduce) end)
    |> Task.await_many()
    |> List.flatten()
    |> Enum.map(fn x -> IO.inspect(x) end)

  end

  @spec executarSync(any(), any()) :: list()
  def executarSync(funcaoMap, _) do
    getRepositorio()
    |> NossoMap.map(funcaoMap)
    |> Enum.to_list()
  end

  def testarSync() do
    executarSync(fn x -> OpCustosa.nth_prime(x) end, fn x -> x * 2 end)
  end

  def listaReducer(chave, lista) do
    {chave, Enum.count(lista)}
  end

  def testar(qtdparticoes) do
    executar(qtdparticoes, &Mapper.map/1, &listaReducer/2)
  end
end

defmodule Mapper do
  def map(elemento) do
    elemento = elemento
                |> String.downcase()
                |> String.replace(~r/[^[:alnum:][:space:]\p{L}]/u, "")

    {elemento, 1}
  end
end
