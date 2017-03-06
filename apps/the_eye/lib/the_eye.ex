defmodule TheEye do
  use Application
  alias Lightning.ColorParsing

  @kernel_module "brcmfmac"
  @interface :wlan0
  @wifi_cfg Application.get_env(:the_eye, @interface)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    neopixel_cfg = Application.get_env(:lightning, :channel0)

    # Define workers and child supervisors to be supervised
    children = [
      worker(Task, [fn -> init_kernel_modules() end], restart: :transient, id: Nerves.Init.KernelModules),
      worker(Task, [fn -> init_network() end], restart: :transient, id: Nerves.Init.Network),
      worker(Task, [fn -> init_ntpd() end], restart: :transient, id: Nerves.Init.Ntpd),
      worker(Nerves.Neopixel, [neopixel_cfg, nil]),
      worker(Task, [fn -> IO.puts("Starting Twitter Connection"); get_tweets('#cmm_storm') end], restart: :transient),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TheEye.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def init_kernel_modules() do
    System.cmd("modprobe", [@kernel_module])
  end

  def init_network() do
    Nerves.InterimWiFi.setup(@interface, @wifi_cfg)
  end

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

  def init_ntpd do
    Process.sleep(8000)
    System.cmd("ntpd", ["-q", "-p", "pool.ntp.org"])
  end
end
