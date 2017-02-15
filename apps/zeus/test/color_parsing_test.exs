defmodule ColorParsingTest do
  use ExUnit.Case
  doctest Zeus.ColorParsing

  describe "parse_rgb_hex" do
    test "parses out three values" do
      assert "#000000"
        |> Zeus.ColorParsing.parse_rgb_hex
        |> Enum.count
        == 3
    end

    test "converts hex numbers to integers" do
      assert "#000000"
        |> Zeus.ColorParsing.parse_rgb_hex
        == [0, 0, 0]
    end

    test "converts other hex numbers" do
      assert "#ffaa11"
        |> Zeus.ColorParsing.parse_rgb_hex
        == [255, 170, 17]
    end
  end

  describe "hex_to_number" do
    test "Converts a small hex number" do
      assert "00"
        |> Zeus.ColorParsing.hex_to_number
        == 0
    end

    test "Converts a large hex number" do
      assert "FF"
        |> Zeus.ColorParsing.hex_to_number
        == 255
    end

    test "is able to work with lower case numbers" do
      assert "aa"
      |> Zeus.ColorParsing.hex_to_number
      == 170
    end
  end
end
