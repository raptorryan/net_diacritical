import Config, only: [config: 2, config: 3]

alias NetDiacritical, as: Core
alias NetDiacriticalWeb, as: Web

alias Core.PubSub
alias Web.Endpoint

config :logger, level: :info
config :net_diacritical, env: [prod: true]

config :net_diacritical, Endpoint,
  adapter: Bandit.PhoenixAdapter,
  force_ssl: [
    host: nil,
    rewrite_on: ~w[x_forwarded_host x_forwarded_port x_forwarded_proto]a
  ],
  http: [port: 4_020, transport_options: [ip: {0, 0, 0, 0, 0, 0, 0, 0}]],
  https: [
    cipher_suite: :strong,
    port: 4_021,
    transport_options: [
      certfile:
        Path.join(__DIR__, "../priv/net_diacritical_web/cert/selfsigned.pem"),
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      keyfile:
        Path.join(
          __DIR__,
          "../priv/net_diacritical_web/cert/selfsigned_key.pem"
        )
    ]
  ],
  pubsub_server: PubSub,
  render_errors: nil,
  secret_key_base:
    "IsibqnyVMpzaQcfSobnHw1KgaAIbVCh0ko1PFgDen0RnTS6PZBfPFsZ2rDhBQTUW",
  url: [host: nil, path: "/", port: 443, scheme: "https"]

config :phoenix, :json_library, Jason
