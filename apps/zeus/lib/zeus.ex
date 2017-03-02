defmodule Zeus do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(Zeus.Endpoint, []),
      worker(Task, [fn -> IO.puts("Starting Zapdos"); Zapdos.get_tweets('#cmm_storm') end], restart: :transient),
      # Start your own worker by calling: Zeus.Worker.start_link(arg1, arg2, arg3)
      # worker(Zeus.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zeus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Zeus.Endpoint.config_change(changed, removed)
    :ok
  end
end
