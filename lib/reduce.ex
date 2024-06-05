defmodule NossoReduce do
	def reduce(particao, reduceUsuario) do
		Enum.map(particao, fn {chave, lista} ->
			reduceUsuario.(chave, lista)
		end)
	end
end
