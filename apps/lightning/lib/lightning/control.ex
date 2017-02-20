defmodule Lightning.Control do
  @renderer Application.get_env(:lightning, :renderer)

  def change_color(color) do
    change_color(color, 125)
  end

  def change_color(color, brightness) do
    change_color(0, color, brightness)
  end

  def change_color(ch, color, brightness) do
    renderer.render(ch, {brightness, [color]})
  end

  def renderer do
    @renderer || Lightning.NeopixelStandin
  end
end
