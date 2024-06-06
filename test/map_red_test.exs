defmodule MapRedTest do
  use ExUnit.Case
  doctest App

  # Call sort function here
  def listaReducer(chave, lista) do
    {chave, Enum.count(lista)}
  end

  test "recebe a lista ordenada e conta a quantidade de elementos" do
    sorted = [{166, [346]}, {186, [302, 274, 265]}, {196, [242, 377]}, {244, [51]}]
    assert NossoReduce.reduce(sorted, &listaReducer/2) == [{166, 1}, {186, 3}, {196, 2}, {244, 1}]
  end

  test "testa o agrupamento e organização dos dados vindos do map" do
    particao =
    [
      [
        {"carregando", 1},
        {"jeito", 1},
        {"carregando", 1},
      ],

      [
        {"carregando", 1},
        {"jeito", 1},
        {"lama", 1},
      ],

      [
        {"jeito", 1},
        {"jeito", 1},
        {"jeito", 1},
        {"jeito", 1},
        {"jeito", 1},
      ]
    ]

    agrupamento = App.agrupar(particao)

    assert agrupamento == [{"carregando", [1, 1, 1]}, {"jeito", [1, 1, 1, 1, 1, 1, 1]}, {"lama", [1]}]
  end

  # test "reduce return" do
  #   # class Adder : public Reducer {
  #   #   virtual void Reduce(ReduceInput* input) {

  #   #     int64 value = 0;
  #   #     while (!input->done()) {
  #   #       value += StringToInt(input->value());
  #   #       input->NextValue();
  #   #     }
  #   #     // Emit sum for input->key()
  #   #     Emit(IntToString(value));
  #   #     }
  #   #   };
  #   def reduce_counter(particao) do
  #     sum = 0
  #     Enum.each(particao, fn sum -> sum++ end)
  #   end

  #   # assert App.reduce == //lista
  # end
end
