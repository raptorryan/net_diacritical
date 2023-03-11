defmodule NetDiacriticalWeb.Endpoint do
  @moduledoc "Defines a `Phoenix.Endpoint` endpoint."
  @moduledoc since: "0.1.0"

  use Phoenix.Endpoint, otp_app: :net_diacritical

  alias NetDiacriticalWeb, as: Web

  alias Web.{Controller, Router}

  alias Controller.Page

  @typedoc "Represents the connection."
  @typedoc since: "0.1.0"
  @type conn() :: Web.conn()

  @typedoc "Represents the connection option."
  @typedoc since: "0.1.0"
  @type opt() :: Web.opt()

  @doc """
  Greets the world (for the given `conn` and `opt`)!

  ## Example

      iex> c = c_request_path_hello()
      iex> %{conn: %{valid: conn}} = c_conn(c)
      iex> %{opt: opt} = c_opt()
      iex> %{status: %{ok: status}} = c_status_ok()
      iex> %{resp_body: resp_body} = c_resp_body_hello()
      iex>
      iex> text_response(hello(conn, opt), status)
      resp_body

  """
  @doc since: "0.1.0"
  @spec hello(conn(), opt()) :: conn()
  def hello(%Plug.Conn{} = conn, _opt) do
    conn |> Phoenix.Controller.accepts(["txt", "text"]) |> Page.call(:hello)
  end

  unless config[:proxy] do
    socket "/socket/" <> config[:session][:signing_salt],
           Phoenix.LiveView.Socket,
           websocket: [connect_info: [session: config[:session]]]
  end

  plug Plug.Static,
    at: "/",
    from: {:net_diacritical, "priv/net_diacritical_web/static"},
    only: Web.static_path()

  if code_reloading? do
    socket "/phoenix/live_reload/socket/net_diacritical/endpoint",
           Phoenix.LiveReloader.Socket

    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, config[:session]
  plug Router
end
