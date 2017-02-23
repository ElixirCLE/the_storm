defmodule Zapdos do
  alias Zapdos.ColorParsing

  @moduledoc """
  Documentation for Zapdos.
  """

  def get_tweets(query) do
    ExTwitter.stream_filter(track: query)
    |> Stream.map(fn(tweet) -> tweet.text end)
    |> Stream.map(fn(text) -> ColorParsing.get_color(text) |> ColorParsing.hex_to_number |> IO.puts end)
    |> Enum.to_list
  end

end
