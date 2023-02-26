defmodule NetDiacriticalWeb.Controller do
  @moduledoc "Defines commonalities for `Phoenix.Controller` controllers."
  @moduledoc since: "0.2.0"

  alias NetDiacriticalWeb, as: Web

  alias Web.{Endpoint, Router}

  @typedoc "Represents the connection."
  @typedoc since: "0.2.0"
  @type conn() :: Web.conn()

  @typedoc "Represents the connection option."
  @typedoc since: "0.2.0"
  @type opt() :: Web.opt()

  @doc """
  In `use`, calls `use Phoenix.Controller`, then stores the associated view.

  ## Example

      iex> defmodule TestController do
      ...>   use NetDiacriticalWeb.Controller,
      ...>     view: [txt: NetDiacriticalWeb.TXT.Page]
      ...>
      ...>   alias NetDiacritical, as: Core
      ...>
      ...>   def hello(%Plug.Conn{} = conn, _param) do
      ...>     render(conn, :hello, greeting: Core.greet())
      ...>   end
      ...> end
      iex>
      iex> c = c_conn()
      iex> %{conn: %{valid: c!}} = c_conn_format_txt(c)
      iex> %{action: %{valid: action}} = c_action_hello()
      iex> conn = TestController.call(c!, action)
      iex>
      iex> Phoenix.Controller.layout(conn)
      false
      iex> Phoenix.Controller.view_module(conn)
      NetDiacriticalWeb.TXT.Page

  """
  @doc since: "0.2.0"
  defmacro __using__(opt) when is_list(opt) do
    quote bind_quoted: [opt: opt] do
      use Phoenix.Controller, Keyword.merge([put_default_views: false], opt)
      use Phoenix.VerifiedRoutes, endpoint: Endpoint, router: Router

      plug :put_new_view, opt[:view]
    end
  end
end
