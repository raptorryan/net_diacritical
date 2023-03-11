defmodule NetDiacriticalWeb do
  @moduledoc "Defines commonalities for `Phoenix` modules."
  @moduledoc since: "0.1.0"

  use Boundary,
    deps: [
      EEx.Engine,
      Logger,
      NetDiacritical,
      Phoenix,
      Phoenix.Component,
      Phoenix.HTML,
      Phoenix.LiveReloader,
      Phoenix.LiveView,
      Phoenix.PubSub,
      Phoenix.Template,
      Plug
    ]

  @typedoc "Represents the static path."
  @typedoc since: "0.3.0"
  @type static_path() :: [Path.t()]

  @typedoc "Represents the connection."
  @typedoc since: "0.1.0"
  @type conn() :: Plug.Conn.t()

  @typedoc "Represents the connection option."
  @typedoc since: "0.1.0"
  @type opt() :: Plug.opts()

  @doc """
  Defines the path for static assets.

  ## Example

      iex> static_path()
      ~w[asset favicon.ico robots.txt]

  """
  @doc since: "0.3.0"
  @spec static_path() :: static_path()
  def static_path() do
    ~w[asset favicon.ico robots.txt]
  end
end
