defmodule Zapdos do
  alias Lightning.ColorParsing

  @moduledoc """
  Documentation for Zapdos.
  """

  def get_tweets(query) do
    ExTwitter.stream_filter(track: query)
    |> Stream.map(fn(tweet) -> tweet.text end)
    |> Stream.map(&(update_color(&1)))
    |> Enum.to_list
  end

  defp update_color(text) do
    ColorParsing.get_color(text)
    |> ColorParsing.parse_rgb_hex
    |> Lightning.Control.change_color(150)
  end

end
