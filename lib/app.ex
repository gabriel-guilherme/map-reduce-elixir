defmodule App do

  def getRepositorio() do
    EntradaSaida.lerRegistros("input.txt")
  end

  defp map(particao, funcaoMap) do
    Task.async(NossoMap, :map, [particao,funcaoMap])
  end

  defp reduce(particao, funcaoMap) do
    Task.async(NossoReduce, :reduce, [particao,funcaoReduce])
  end

  def executar(qtdparticoes, funcaoMap, _) do
    getRepositorio()
    |>Particao.particionar(qtdparticoes)
    |>Enum.map(fn particao -> map(particao,funcaoMap) end )
    # Esperar por uma lista de tasks
    |>Task.await_many
    |> List.flatten()
    |> Enum.group_by(fn {key, _} -> key end, fn {_, valor} -> valor end)
    |> Map.to_list
    |> Particao.particionar(qtdparticoes)
    |> Enum.Map(fn particao -> reduce(particao, funcaoReduce end))
    |> Task.await_many
  end

  def executarSync(funcaoMap, _) do
    getRepositorio()
    |>NossoMap.map(funcaoMap)
    |>Enum.to_list
  end

  def testarSync() do
    executarSync(fn x -> OpCustosa.nth_prime(x) end, fn x -> x*2 end )
  end

  def testar(qtdparticoes) do
    executar(qtdparticoes,fn x -> Mapper.map(x) end, fn x -> x*2 end )
  end

end

## MODULO COM UMA FUNÇÃO CUSTOSA GERADA PELO CHAT GPT
defmodule OpCustosa do

  # Função para encontrar o n-ésimo número primo
  def nth_prime(n) when n <= 0 do
    {:error, "Input must be a positive integer"}
  end

  def nth_prime(n) do
    nth_prime(n, 2, 0)
  end

  # Função auxiliar recursiva para encontrar o n-ésimo número primo
  defp nth_prime(n, candidate, count) do
    if is_prime(candidate) do
      if count + 1 == n do
        candidate
      else
        nth_prime(n, candidate + 1, count + 1)
      end
    else
      nth_prime(n, candidate + 1, count)
    end
  end

  # Função para verificar se um número é primo
  defp is_prime(2), do: true
  defp is_prime(n) when n < 2 or rem(n, 2) == 0, do: false
  defp is_prime(n) do
    is_prime(n, 3)
  end

  defp is_prime(n, divisor) when divisor * divisor > n, do: true
  defp is_prime(n, divisor) do
    if rem(n, divisor) == 0 do
      false
    else
      is_prime(n, divisor + 2)
    end
  end
end

defmodule Mapper do
  def map(input) do
    {String.to_atom(input), 1}
  end
end
