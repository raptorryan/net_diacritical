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
  force_watchers: true,
  live_reload: [
    patterns: [
      ~r/lib\/net_diacritical_web\/(?:controller|html|txt)\/.*(?:ex)$/,
      ~r/priv\/net_diacritical_web\/static\/.*(?:css|ico|js|txt)$/
    ],
    suffix: "/net_diacritical/endpoint"
  ],
  url: [host: "localhost", path: "/", port: 4_005, scheme: "https"],
  watchers: [
    esbuild: {
      Esbuild,
      :install_and_run,
      [:net_diacritical_web, ["--sourcemap=inline", "--watch"]]
    }
  ]

config :phoenix, :stacktrace_depth, 32
