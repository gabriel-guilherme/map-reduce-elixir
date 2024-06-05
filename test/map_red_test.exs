defmodule MapRedTest do
  use ExUnit.Case
  doctest MapRed

  test "greets the world" do
    assert MapRed.hello() == :world
  end

  test "recebe a lista ordenada e conta a quantidade de elementos" do
    # Call sort function here
    sorted = %{166 => [346], 186 => [302, 274, 265], 196 => [242, 377], 244 => [51]}
    assert MapRed.reduce(186, sorted[186], &Enum.count/1) == %{186 => 3}
  end

  test "reduce return" do
    # class Adder : public Reducer {
    #   virtual void Reduce(ReduceInput* input) {

    #     int64 value = 0;
    #     while (!input->done()) {
    #       value += StringToInt(input->value());
    #       input->NextValue();
    #     }
    #     // Emit sum for input->key()
    #     Emit(IntToString(value));
    #     }
    #   };
    def reduce_counter(particao) do
      sum = 0
      Enum.each(particao, fn sum -> sum++ end)
    end

    # assert MapRed.reduce == //lista
  end
end
