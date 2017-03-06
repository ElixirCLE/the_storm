defmodule Lightning.Control do
  @renderer Application.get_env(:lightning, :renderer)

  def change_color(color) do
    change_color(color, 125)
  end

  def change_color(color, brightness) do
    change_color(0, color, brightness)
  end

  def change_color(channel, color, brightness) do
    IO.puts renderer()
    IO.puts("Rendering #{inspect([color])} at brightness #{inspect(brightness)} to channel #{inspect(channel)}")
    renderer().render(channel, {brightness, [color]})
  end

  def renderer do
    # @renderer || Lightning.NeopixelStandin
    Nerves.Neopixel
  end
end
