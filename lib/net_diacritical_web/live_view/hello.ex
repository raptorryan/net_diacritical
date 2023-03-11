defmodule NetDiacriticalWeb.LiveView.Hello do
  @moduledoc "Defines a `Phoenix.LiveView` live view."
  @moduledoc since: "0.4.0"

  use NetDiacriticalWeb.LiveView

  alias NetDiacritical, as: Core
  alias NetDiacriticalWeb, as: Web

  alias Web.LiveView

  @typedoc "Represents the parameter map."
  @typedoc since: "0.4.0"
  @type param() :: LiveView.param()

  @typedoc "Represents the session map."
  @typedoc since: "0.4.0"
  @type session() :: LiveView.session()

  @typedoc "Represents the socket."
  @typedoc since: "0.4.0"
  @type socket() :: LiveView.socket()

  @typedoc "Represents the mount."
  @typedoc since: "0.4.0"
  @type mount() :: LiveView.mount()

  @typedoc "Represents the assigns."
  @typedoc since: "0.4.0"
  @type assigns() :: LiveView.assigns()

  @typedoc "Represents the render."
  @typedoc since: "0.4.0"
  @type render() :: LiveView.render()

  @impl Phoenix.LiveView
  @doc """
  Defines an entrypoint with the given `param`, `session` and `socket`.

  ## Example

      iex> %{param: %{valid: param}} = c_param()
      iex> %{session: %{valid: session}} = c_session()
      iex> %{socket: %{valid: socket}} = c_socket(%{})
      iex>
      iex> {:ok, %Phoenix.LiveView.Socket{}} = mount(param, session, socket)

  """
  @doc since: "0.4.0"
  @spec mount(param(), session(), socket()) :: mount()
  def mount(param, session, %Phoenix.LiveView.Socket{} = socket)
      when (is_map(param) or is_atom(param)) and is_map(session) do
    {:ok, assign(socket, greeting: Core.greet())}
  end

  @impl Phoenix.LiveView
  @doc """
  Renders a template for the given `assigns`.

  ## Example

      iex> %{assigns: %{valid: assigns}} = c_assigns_greeting()
      iex> c = c_resp_body_hello()
      iex> %{resp_body: resp_body} = c_resp_body_to_html(c)
      iex>
      iex> render_component(Hello, assigns) =~ resp_body

  """
  @doc since: "0.4.0"
  @spec render(assigns()) :: render()
  def render(assigns) when is_map(assigns) do
    ~H"<span><%= @greeting %></span>"
  end
end
