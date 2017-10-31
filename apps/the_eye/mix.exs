defmodule TheEye.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :the_eye,
     version: "0.1.0",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.6.3"],

     deps_path: "../../deps/#{@target}",
     build_path: "../../_build/#{@target}",
     config_path: "../../config/config.exs",
     lockfile: "../../mix.lock",

     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {TheEye, []},
     applications: [:logger, :nerves_network, :nerves_neopixel, :lightning, :zeus]]
  end

  def deps do
    [
      {:nerves, "~> 0.7.5"},
      {:nerves_neopixel, "~> 0.3.1"},
      {:nerves_network, "~> 0.3"},
      {:lightning, in_umbrella: true},
      {:zeus, in_umbrella: true},
    ]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"],
     "burn": ["compile", "firmware", "firmware.burn"]]
  end

end
