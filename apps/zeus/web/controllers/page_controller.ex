defmodule Zeus.PageController do
  use Zeus.Web, :controller
  alias Zeus.ColorParsing

  def index(conn, _params) do
    render conn, "index.html"
  end

  def update(conn, %{"choose" => %{"color" => chosen_color} } ) do
    IO.puts chosen_color |> ColorParsing.parse_rgb_hex
    #TODO: pass parsed color to something that can change color of neopixel
    render conn, "index.html"
  end
end
