defmodule AwesomeList.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised

    common_children = [
      # Start the Ecto repository
      AwesomeList.Repo,
      # Start the endpoint when the application starts
      AwesomeListWeb.Endpoint,
    ]

    # Run scheduler only in prod and dev environments
    children = case Mix.env() do
      :test -> common_children
      _     -> common_children ++ [AwesomeList.Scheduler]
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AwesomeList.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AwesomeListWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
