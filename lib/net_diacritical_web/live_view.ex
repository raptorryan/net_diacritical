defmodule NetDiacriticalWeb.LiveView do
  @moduledoc "Defines commonalities for `Phoenix.LiveView` views."
  @moduledoc since: "0.4.0"

  import NetDiacriticalWeb.Token, only: [verify: 1]
  import Phoenix.Component, only: [assign_new: 3]
  import Phoenix.LiveView

  alias NetDiacriticalWeb, as: Web

  alias Web.{Endpoint, HTML, Router}

  alias HTML.Layout

  @typedoc "Represents the socket."
  @typedoc since: "0.4.0"
  @type socket() :: Phoenix.LiveView.Socket.t()

  @typedoc "Represents the potential nonce."
  @typedoc since: "0.4.0"
  @type csp_nonce?() :: binary() | nil

  @typedoc "Represents the session name."
  @typedoc since: "0.4.0"
  @type name() :: atom()

  @typedoc "Represents the parameter map."
  @typedoc since: "0.4.0"
  @type param() :: Phoenix.LiveView.unsigned_params()

  @typedoc "Represents the session map."
  @typedoc since: "0.4.0"
  @type session() :: map()

  @typedoc "Represents the status."
  @typedoc since: "0.4.0"
  @type status() :: :cont | :halt

  @typedoc "Represents the hook."
  @typedoc since: "0.4.0"
  @type hook() :: {status(), socket()}

  @typedoc "Represents the opt keyword."
  @typedoc since: "0.4.0"
  @type opt_keyword() ::
          {:layout, {module, String.t()}}
          | {:temporary_assigns, Keyword.t()}

  @typedoc "Represents the opt."
  @typedoc since: "0.4.0"
  @type opt() :: [opt_keyword()]

  @typedoc "Represents the mount."
  @typedoc since: "0.4.0"
  @type mount() :: {:ok, socket()} | {:ok, socket(), opt()}

  @typedoc "Represents the assigns."
  @typedoc since: "0.4.0"
  @type assigns() :: Phoenix.LiveView.Socket.assigns()

  @typedoc "Represents the render."
  @typedoc since: "0.4.0"
  @type render() :: Phoenix.LiveView.Rendered.t()

  @spec maybe_get_csp_nonce(socket()) :: csp_nonce?()
  defp maybe_get_csp_nonce(%Phoenix.LiveView.Socket{} = socket) do
    if connected?(socket) do
      token? = get_connect_params(socket)["_csp_token"]

      case verify(token?) do
        {:error, _} -> nil
        {:ok, nonce} -> nonce
      end
    end
  end

  @doc """
  Attaches a hook to apply common assignments on to a given `socket`.

  ## Example

      iex> %{name: %{valid: name}} = c_name_default(%{})
      iex> %{param: %{valid: param}} = c_param(%{})
      iex> %{session: %{valid: session}} = c_session(%{})
      iex> %{socket: %{halted: halted, unsigned: unsigned}} =
      ...>   c_socket_csp_nonce(%{})
      iex>
      iex> on_mount(name, param, session, unsigned)
      {:halt, halted}

      iex> %{name: %{valid: name}} = c_name_default(%{})
      iex> %{param: %{valid: param}} = c_param(%{})
      iex> %{session: %{valid: session}} = c_session(%{})
      iex> %{socket: %{mounted: mounted, signed: signed}} =
      ...>   c_socket_csp_nonce(%{})
      iex>
      iex> on_mount(name, param, session, signed)
      {:cont, mounted}

      iex> %{name: %{valid: name}} = c_name_default(%{})
      iex> %{param: %{valid: param}} = c_param(%{})
      iex> %{session: %{valid: session}} = c_session(%{})
      iex> %{socket: %{assigned: socket}} = c_socket_csp_nonce(%{})
      iex>
      iex> on_mount(name, param, session, socket)
      {:cont, socket}

  """
  @doc since: "0.4.0"
  @spec on_mount(name(), param(), session(), socket()) :: hook()
  def on_mount(name, param, session, %Phoenix.LiveView.Socket{} = socket)
      when is_atom(name) and is_map(param) and is_map(session) do
    nonce? = maybe_get_csp_nonce(socket)

    if connected?(socket) && !nonce? do
      {:halt, redirect(socket, to: "/hello")}
    else
      {:cont, assign_new(socket, :nonce, fn -> nonce? end)}
    end
  end

  @doc """
  In `use`, calls `use Phoenix.LiveView` with a defined `:layout` and hooks.

  ## Example

      iex> defmodule TestLiveView do
      ...>   use NetDiacriticalWeb.LiveView
      ...>
      ...>   alias NetDiacritical, as: Core
      ...>
      ...>   @impl Phoenix.LiveView
      ...>   def mount(param, session, %Phoenix.LiveView.Socket{} = socket)
      ...>       when (is_map(param) or is_atom(param)) and is_map(session) do
      ...>     {:ok, assign(socket, greeting: Core.greet())}
      ...>   end
      ...>
      ...>   @impl Phoenix.LiveView
      ...>   def render(assigns) when is_map(assigns) do
      ...>     ~H"<span><%= @greeting %></span>"
      ...>   end
      ...> end
      iex>
      iex> %{assigns: %{valid: assigns}} = c_assigns_greeting()
      iex> c = c_resp_body_hello()
      iex> %{resp_body: resp_body} = c_resp_body_to_html(c)
      iex>
      iex> TestLiveView.__live__()
      %{
        container: {:div, []},
        kind: :view,
        layout: {Layout, "app"},
        lifecycle: %Phoenix.LiveView.Lifecycle{
          mount: [
            %{
              function: &LiveView.on_mount/4,
              id: {LiveView, :default},
              stage: :mount
            }
          ]
        },
        log: :debug,
        module: __MODULE__.TestLiveView,
        name: "LiveViewTest.TestLiveView"
      }
      iex> render_component(TestLiveView, assigns) =~ resp_body
      true

  """
  @doc since: "0.4.0"
  defmacro __using__(opt) when is_list(opt) do
    quote do
      use Phoenix.LiveView,
          Keyword.merge([layout: {Layout, :app}], unquote(opt))

      use Phoenix.VerifiedRoutes,
        endpoint: Endpoint,
        router: Router,
        statics: Web.static_path()

      on_mount(unquote(__MODULE__))
    end
  end
end
