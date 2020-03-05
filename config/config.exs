# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :payments,
  ecto_repos: [Payments.Repo]

# Configures the endpoint
config :payments, PaymentsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SLOS1MXnGzXVBMyzgFdJ1evOLB8UQJuqz/b/VTn5sQowG/52Uxs83rUe665pN8H+",
  render_errors: [view: PaymentsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Payments.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#braintree configuration
config :braintree,
  environment: :sandbox,
  master_merchant_id: "srh9fm8v2gwk5p5y",
  merchant_id: "srh9fm8v2gwk5p5y",
  public_key: "gvvypwyqyxgpy7fp",
  private_key: "3aa6fc4d1b1d5f6a5ac33be325e101e6"

#config :braintree,
#  environment: :sandbox,
##  master_merchant_id: {:system, "srh9fm8v2gwk5p5y"},
#  merchant_id: "5dbr2gmqbtkmd344",
#  public_key: "hz6wbyrgn587rjjx",
#  private_key: "4be281487e762d0e0d7cbe7abb98224a"


# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
