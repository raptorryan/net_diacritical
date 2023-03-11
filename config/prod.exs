import Config, only: [config: 2, config: 3]

alias NetDiacritical, as: Core
alias NetDiacriticalWeb, as: Web

alias Core.PubSub
alias Web.{Endpoint, HTML, TXT}

config :esbuild,
  net_diacritical_web: [
    args: [
      "js/app.js",
      "vendor/inter/inter.css",
      "--loader:.woff2=file",
      "--loader:.woff=file",
      "--bundle",
      "--target=es2017",
      "--outdir=../../priv/net_diacritical_web/static/asset"
    ],
    cd: Path.expand("../asset/net_diacritical_web", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../../../dep", __DIR__)}
  ],
  version: "0.17.11"

config :logger, level: :info
config :net_diacritical, env: [prod: true]

config :net_diacritical, Endpoint,
  adapter: Bandit.PhoenixAdapter,
  cache_static_manifest: "priv/net_diacritical_web/static/cache_manifest.json",
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
  live_view: [signing_salt: "njOSbB8KYFDwWY3G"],
  pubsub_server: PubSub,
  render_errors: [formats: [html: HTML.Error, txt: TXT.Error]],
  secret_key_base:
    "IsibqnyVMpzaQcfSobnHw1KgaAIbVCh0ko1PFgDen0RnTS6PZBfPFsZ2rDhBQTUW",
  session: [
    key: "__Host-session",
    same_site: "Strict",
    signing_salt: "JiLge0f4LyjBNyrd",
    store: :cookie
  ],
  url: [host: nil, path: "/", port: 443, scheme: "https"]

config :phoenix, :json_library, Jason

config :tailwind,
  net_diacritical_web: [
    args: [
      "--config=tailwind.config.js",
      "--input=css/app.css",
      "--output=../../priv/net_diacritical_web/static/asset/css/app.css"
    ],
    cd: Path.expand("../asset/net_diacritical_web", __DIR__)
  ],
  version: "3.2.7"
