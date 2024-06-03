defmodule NossoReduce do
	def reduce(particao, reduceUsuario) do
		Enum.each(particao, fn {chave, lista} ->
			%{chave => reduceUsuario.(chave, lista)}
		end)

	end
end
