import Config, only: [config_env: 0, config: 3]

alias NetDiacriticalWeb, as: Web

alias Web.Endpoint

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      The environment variable `SECRET_KEY_BASE` has not been set.
      You can generate a secret key base value by calling `mix phx.gen.secret`.
      """

  config :net_diacritical, Endpoint, secret_key_base: secret_key_base
end
