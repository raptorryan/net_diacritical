defmodule NetDiacriticalWeb.Controller.Page do
  @moduledoc "Defines a `Phoenix.Controller` controller."
  @moduledoc since: "0.2.0"

  use NetDiacriticalWeb.Controller, view: [txt: NetDiacriticalWeb.TXT.Page]

  alias NetDiacritical, as: Core
  alias NetDiacriticalWeb, as: Web

  alias Web.Controller

  @typedoc "Represents the connection."
  @typedoc since: "0.2.0"
  @type conn() :: Controller.conn()

  @typedoc "Represents the connection option."
  @typedoc since: "0.2.0"
  @type opt() :: Controller.opt()

  @doc """
  Defines a controller action, `:hello`, with the given `conn` and `opt`.

  ## Example

      iex> c! = c_request_path_hello()
      iex> c! = c_conn(c!)
      iex> %{conn: %{valid: conn}} = c_conn_format_txt(c!)
      iex> %{action: %{valid: action}} = c_action_hello()
      iex> %{status: %{ok: status}} = c_status_ok()
      iex> %{resp_body: resp_body} = c_resp_body_hello()
      iex>
      iex> text_response(call(conn, action), status)
      resp_body

  """
  @doc since: "0.2.0"
  @spec hello(conn(), opt()) :: conn()
  def hello(%Plug.Conn{} = conn, _opt) do
    render(conn, :hello, greeting: Core.greet())
  end
end
