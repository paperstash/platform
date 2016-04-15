use Mix.Config

import_config "../apps/*/config/config.exs"

# The configuration defined here will only affect the dependencies in the apps
# directory when commands are executed from the umbrella project.

import_config "#{Mix.env}.exs"
