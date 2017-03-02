defmodule Zapdos do
  alias Lightning.ColorParsing

  @moduledoc """
  Documentation for Zapdos.
  """

  def get_tweets(query) do
    Process.sleep(10000)
    IO.puts "get_tweets: #{query}"
    ExTwitter.stream_filter(track: query)
    |> Stream.map(fn(tweet) -> tweet.text end)
    |> Stream.map(&(update_color(&1)))
    |> Enum.to_list
  end

  defp update_color(text) do
    IO.puts "update_color: #{text}"
    ColorParsing.get_color(text)
    |> ColorParsing.parse_rgb_hex
    |> Lightning.Control.change_color(150)
  end

end
