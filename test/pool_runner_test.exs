defmodule Demo do
  def eggcellent(val \\ 1) do
    IO.puts "In - #{val}"
    :timer.sleep(300 * val)
    IO.puts "Finishing - #{val}"
    val
  end
end

defmodule PoolRunnerTest do
  use ExUnit.Case
  import Demo

  test "I don't know how to test this" do
    functions = [
      fn -> eggcellent end,
      fn -> eggcellent(8) end,
      fn -> eggcellent(3) end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent(9) end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end,
      fn -> eggcellent end
    ]

    PoolRunner.run(3, functions)

    :timer.sleep(5000)
  end

  test "another" do
    functions = [
      fn -> IO.puts "Wow" end,
      fn -> IO.puts "This" end,
      fn -> IO.puts "is" end,
      fn -> IO.puts "really" end,
      fn -> IO.puts "wonderful" end,
    ]
    PoolRunner.run(3, functions)

    :timer.sleep(2000)
  end
end
