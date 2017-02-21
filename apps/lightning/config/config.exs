# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :lightning, :channel0,
  pin: 18,
  count: 1

config :lightning, renderer: Lightning.NeopixelStandin
