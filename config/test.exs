use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :awesome_list, AwesomeListWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :awesome_list, AwesomeList.Repo,
  username: "postgres",
  password: "postgres",
  database: "awesome_list_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

config :awesome_list, :github_api, AwesomeList.GithubApiFs
config :awesome_list, github_awesome_repo: "awesome_list.md"
