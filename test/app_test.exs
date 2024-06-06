defmodule AppTest do
  use ExUnit.Case
  doctest App

  test "agrupamento" do
    particao =
    [
      [{"carregando", 1},{"jeito", 1},{"carregando", 1}],
      [{"carregando", 1},{"jeito", 1},{"lama", 1}],
      [{"jeito", 1},{"jeito", 1},{"jeito", 1},{"jeito", 1},
      ]
    ]
    assert App.agrupar(particao) == [{"carregando", [1, 1, 1]}, {"jeito", [1, 1, 1, 1, 1, 1]}, {"lama", [1]}]
  end

  test "reduce-concorrente" do
    particao = [ {"casa",[1,1,1,1] }, {"bola", [1]}, {"teste", [1, 1]} ]
    assert App.reduceConcorrente(particao, &Usuario.reduce/2)|>Task.await() == [{"casa", 4}, {"bola", 1}, {"teste", 2}]
  end

  test "map-concorrente" do
    particao = ["casa", "bola", "gato", "mar", "casa", "casa", "mar"]
    assert App.mapConcorrente(particao, &Usuario.map/1)|>Task.await() == [{"casa", 1}, {"bola", 1}, {"gato", 1}, {"mar", 1}, {"casa", 1}, {"casa", 1}, {"mar", 1}]
  end

  test "executar" do
    resultado = [{"album", 3},{"amigo", 1},{"bola", 1},{"cachorro", 1},{"casa", 2},{"gato", 1},{"gente", 4},{"mar", 1},{"rua", 1}]
    assert App.executar("input.txt", 3,  &Usuario.map/1,  &Usuario.reduce/2) == resultado
  end

  test "demo" do
    resultado = [{"album", 3},{"amigo", 1},{"bola", 1},{"cachorro", 1},{"casa", 2},{"gato", 1},{"gente", 4},{"mar", 1},{"rua", 1}]
    assert App.demo("input.txt", 3) == resultado
  end

end