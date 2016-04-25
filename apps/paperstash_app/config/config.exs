use Mix.Config

# HACK(mtwilliams): Disable live reloading because it does not currently work
# within umbrella projects. https://github.com/hexedpackets/trot/issues/23
config :trot, :pre_routing, [
  "Elixir.Plug.Logger": [],
  "Elixir.Plug.Parsers": [
    parsers: [:urlencoded, :json],
    pass: ["*/*"],
    json_decoder: Poison
  ]
]

import_config "#{Mix.env}.exs"
