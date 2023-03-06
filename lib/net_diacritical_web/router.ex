defmodule NetDiacriticalWeb.Router do
  @moduledoc "Defines a `Phoenix.Router` router."
  @moduledoc since: "0.2.0"

  use Phoenix.Router, helpers: false

  alias NetDiacriticalWeb, as: Web

  alias Web.{Controller, Endpoint, HTML}

  @typedoc "Represents the connection."
  @typedoc since: "0.3.0"
  @type conn() :: Web.conn()

  @typedoc "Represents the connection option."
  @typedoc since: "0.3.0"
  @type opt() :: Web.opt()

  @config Phoenix.Endpoint.Supervisor.config(:net_diacritical, Endpoint)

  @spec put_csp_nonce(conn(), opt()) :: conn()
  defp put_csp_nonce(%Plug.Conn{} = conn, _opt) do
    18
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> then(&assign(conn, :nonce, &1))
  end

  @spec put_secure_headers(conn(), opt()) :: conn()
  defp put_secure_headers(%Plug.Conn{assigns: %{nonce: nonce}} = conn, _opt) do
    cross_origin_embedder_policy =
      if @config[:code_reloader] do
        "unsafe-none"
      else
        "require-corp"
      end

    put_secure_browser_headers(
      conn,
      %{
        "content-security-policy" =>
          "base-uri 'self'; " <>
            "connect-src 'self' wss://#{conn.host}:#{conn.port}; " <>
            "default-src 'self'; " <>
            "form-action 'self'; " <>
            "frame-ancestors 'self'; " <>
            "img-src 'self' 'nonce-#{nonce}'; " <>
            "object-src 'none'; " <>
            "script-src 'self' 'unsafe-inline' 'nonce-#{nonce}'; " <>
            "style-src 'self' 'nonce-#{nonce}'; " <>
            "upgrade-insecure-requests",
        "cross-origin-embedder-policy" => cross_origin_embedder_policy,
        "cross-origin-opener-policy" => "same-origin",
        "cross-origin-resource-policy" => "same-origin",
        "permissions-policy" =>
          "accelerometer=(), ambient-light-sensor=(), autoplay=(), " <>
            "battery=(), bluetooth=(), camera=(), cross-origin-isolated=(), " <>
            "display-capture=(), encrypted-media=(), " <>
            "execution-while-not-rendered=(), " <>
            "execution-while-out-of-viewport=(), fullscreen=(), " <>
            "geolocation=(), gyroscope=(), hid=(), idle-detection=(), " <>
            "keyboard-map=(), magnetometer=(), microphone=(), midi=(), " <>
            "navigation-override=(), payment=(), picture-in-picture=(), " <>
            "publickey-credentials-get=(), screen-wake-lock=(), serial=(), " <>
            "sync-xhr=(), usb=(), web-share=(), xr-spatial-tracking=()",
        "referrer-policy" => "no-referrer"
      }
    )
  end

  pipeline :browser do
    plug :accepts, ["html", "htm"]
    plug :fetch_session
    plug :put_root_layout, {HTML.Layout, :root}
    plug :protect_from_forgery
    plug :put_csp_nonce
    plug :put_secure_headers
  end

  pipeline :plaintext do
    plug :accepts, ["txt", "text"]
  end

  scope "/" do
    pipe_through :browser

    get "/", Controller.Page, :hello
  end

  scope "/" do
    pipe_through :plaintext

    get "/hello", Controller.Page, :hello
  end
end
