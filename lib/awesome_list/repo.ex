defmodule AwesomeList.Repo do
  use Ecto.Repo,
    otp_app: :awesome_list,
    adapter: Ecto.Adapters.Postgres
end
