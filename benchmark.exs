defmodule Benchmark do

lista = Enum.to_list(1..100000)

Benchee.run(%{ 
    "particionar nao-recursivo 15 part" => fn -> Particao.particionar(lista,15) end,
    "particionar nao-recursivo 50 part" => fn -> Particao.particionar(lista,50) end,
    "particionar nao-recursivo 300 part" => fn -> Particao.particionar(lista,300) end,
    "particionar recursivo 15 part" => fn -> TesteDesempenho.particionar(lista,15) end,
    "particionar recursivo 50 part" => fn -> TesteDesempenho.particionar(lista,50) end,
    "particionar recursivo 300 part" => fn -> TesteDesempenho.particionar(lista,300) end,
}, memory_time: 2)

end