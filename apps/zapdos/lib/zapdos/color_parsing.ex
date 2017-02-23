defmodule Zapdos.ColorParsing do
  def get_color("Color: #" <> <<raw_hex::bytes-size(6)>> <> _), do: raw_hex

  def get_color(_), do: "FFFFFF"

  def parse_rgb_hex(rgb_value) do
    [r1, r2, g1, g2, b1, b2] = rgb_value |> String.codepoints |> Enum.take(-6)
    {hex_to_number(r1 <> r2), hex_to_number(g1 <> g2), hex_to_number(b1 <> b2)}
  end

  def hex_to_number(hex_value) do
    hex_value |> String.upcase |> Base.decode16! |> :binary.decode_unsigned
  end
end

