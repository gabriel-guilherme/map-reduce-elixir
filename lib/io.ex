defmodule ES do
  def lerArquivo(path) do
    case File.read(path) do
      {:ok, conteudo} ->
        conteudo
        |> String.replace(~r/\r?\n/, " ")
        |> String.split(" ")

      {:error, _reason} ->
        IO.puts("Erro ao ler o arquivo")
        %{}
    end
  end
end
