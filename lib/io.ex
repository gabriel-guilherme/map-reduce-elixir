defmodule EntradaSaida do
  def lerRegistros(path) do
    case File.read(path) do
      {:ok, conteudo} ->
        String.split(conteudo, " ")
      {:error, _reason} ->
        IO.puts("Erro ao ler o arquivo")
        []
    end
  end
end
