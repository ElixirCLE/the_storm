# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :the_eye, :default,
  wlan0: [
    key_mgmt: :"WPA-PSK",
    ssid: "CoverMyMeds-Guest",
    psk: "technology"
  ]

config :zeus, Zeus.Endpoint,
  http: [port: 80],
  url: [host: "localhost", port: 80],
  secret_key_base: "Q8bCLHDz9QAcJ8ZRA2fWwUWSbglcYv3YxiLhBB2ZlRoqJydRyIWrtkllBPXtdaPp",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Nerves.PubSub]

config :nerves_network,
  regulatory_domain: "US"

config :logger, level: :debug

config :nerves, :firmware,
  rootfs_additions: "config/rootfs-additions"

config :lightning, :channel0,
  pin: 18,
  count: 1

config :lightning, renderer: Nerves.Neopixel
