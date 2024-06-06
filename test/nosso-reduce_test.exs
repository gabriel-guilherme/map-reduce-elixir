defmodule NossoReduceTest do
  use ExUnit.Case
  doctest NossoReduce

test "reduce" do
    grupo = [ {"casa",[1,1,1,1] }, {"bola", [1]}, {"teste", [1, 1]} ]
    assert NossoReduce.reduce(grupo, &Usuario.reduce/2) == [{"casa", 4}, {"bola", 1}, {"teste", 2}]
  end
end