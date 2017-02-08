defmodule Lightning do
  alias Nerves.Neopixel

  def set_light do
    IO.puts "something might light up now"
    {:ok, pid} = Neopixel.setup pin: 18, count: 1
    :ok = Neopixel.render(pid, << 255, 0, 0 >>)
  end
end
