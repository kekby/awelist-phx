# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :awesome_list,
  ecto_repos: [AwesomeList.Repo]

# Configures the endpoint
config :awesome_list, AwesomeListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cr8igJ5ecNOegcD9qnun2D9E7o3p415ZNca4/2gstv95K9WZDHwUSfTfTkYvEuU+",
  render_errors: [view: AwesomeListWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AwesomeList.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :awesome_list, AwesomeList.Scheduler,
  jobs: [
    # Run at startup:
    {"@reboot", {AwesomeList.Loader, :check_and_run, []}},
    # Runs every midnight:
    {"@daily", {AwesomeList.Loader, :get_and_save_list, []}}
  ]

config :awesome_list,
  github_awesome_repo: "https://raw.githubusercontent.com/h4cc/awesome-elixir/master/README.md"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
