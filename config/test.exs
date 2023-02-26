import Config, only: [config: 2, config: 3, import_config: 1]

alias NetDiacriticalWeb, as: Web

alias Web.Endpoint

import_config "prod.exs"

config :logger, level: :warning
config :net_diacritical, env: [test: true]

config :net_diacritical, Endpoint,
  http: [port: 4_022],
  https: [port: 4_023],
  url: [host: "localhost", path: "/", port: 4_003, scheme: "https"]

config :phoenix, :plug_init_mode, :runtime
