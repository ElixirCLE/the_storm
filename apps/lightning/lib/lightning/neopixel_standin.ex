defmodule Lightning.NeopixelStandin do
  def render(channel, {brightness, color_array}) do
    IO.puts("Rendering #{inspect(color_array)} at brightness #{inspect(brightness)} to channel #{inspect(channel)}")
  end
end
