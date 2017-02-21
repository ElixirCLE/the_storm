defmodule Zeus.PageController do
  use Zeus.Web, :controller
  alias Zeus.ColorParsing

  def index(conn, _params) do
    render conn, "index.html", color: nil, brightness: nil
  end

  def update(conn, %{"choose" => %{"color" => chosen_color, "brightness" => chosen_brightness} } ) do
    chosen_color |> ColorParsing.parse_rgb_hex |> Lightning.Control.change_color(String.to_integer(chosen_brightness))
    render conn, "index.html", color: chosen_color, brightness: chosen_brightness
  end
end
