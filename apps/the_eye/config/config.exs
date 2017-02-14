# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :the_eye, :wlan0,
  ssid: "CoverMyMeds-Guest",
  key_mgmt: :"WPA-PSK",
  psk: "technology"

config :nerves_interim_wifi,
  regulatory_domain: "US"

config :logger, level: :debug

config :nerves, :firmware,
  rootfs_additions: "config/rootfs-additions"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
