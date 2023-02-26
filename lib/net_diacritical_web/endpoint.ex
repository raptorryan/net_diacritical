defmodule NetDiacriticalWeb.Endpoint do
  @moduledoc "Defines a `Phoenix.Endpoint` endpoint."
  @moduledoc since: "0.1.0"

  use Phoenix.Endpoint, otp_app: :net_diacritical

  alias NetDiacriticalWeb, as: Web

  alias Web.Controller

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

  plug :hello
end
