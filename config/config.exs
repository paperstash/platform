use Mix.Config

config :logger,
  level: :info,
  handle_otp_reports: true,
  handle_sasl_reports: false,
  utc_log: true,
  backends: [:console]

config :logger, :console,
  level: :info,
  format: "$date $time [$level] $metadata$message\n",
  metadata: []

# The configuration defined here will only affect the dependencies in the apps
# directory when commands are executed from the umbrella project.

import_config "#{Mix.env}.exs"

import_config "../apps/*/config/config.exs"
