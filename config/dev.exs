import Config, only: [config: 2, config: 3, import_config: 1]

alias NetDiacriticalWeb, as: Web

alias Web.Endpoint

import_config "test.exs"

config :logger, level: :debug
config :net_diacritical, env: [dev: true]

config :net_diacritical, Endpoint,
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  http: [port: 4_024],
  https: [port: 4_025],
  url: [host: "localhost", path: "/", port: 4_005, scheme: "https"]

config :phoenix, :stacktrace_depth, 32
