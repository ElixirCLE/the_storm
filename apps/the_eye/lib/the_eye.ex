defmodule TheEye do
  use Application

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
      worker(Nerves.Neopixel, [neopixel_cfg, nil]),
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

end
