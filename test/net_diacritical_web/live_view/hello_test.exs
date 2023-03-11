defmodule NetDiacriticalWeb.LiveView.HelloTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use NetDiacriticalCase.Conn, async: true

  alias NetDiacriticalCase, as: Case
  alias NetDiacriticalWeb, as: Web

  alias Web.{HTML, LiveView}

  alias HTML.Layout
  alias LiveView.Hello

  @typedoc "Represents the current context."
  @typedoc since: "0.4.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.4.0"
  @type context_merge() :: Case.context_merge()

  @spec c_socket(context()) :: context_merge()
  defp c_socket(c) when is_map(c) do
    %{socket: %{invalid: %{}, valid: %Phoenix.LiveView.Socket{}}}
  end

  doctest Hello, import: true

  describe "__components__/0" do
    import Hello, only: [__components__: 0]

    test "success" do
      assert __components__() == %{}
    end
  end

  describe "__live__/0" do
    import Hello, only: [__live__: 0]

    test "success" do
      assert __live__() == %{
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
               module: Hello,
               name: "LiveView.Hello"
             }
    end
  end

  describe "__phoenix_verify_routes__/1" do
    import Hello, only: [__phoenix_verify_routes__: 1]

    test "success" do
      assert __phoenix_verify_routes__(Hello) == :ok
    end
  end

  describe "mount/3" do
    import Hello, only: [mount: 3]

    setup ~w[c_param c_session c_socket]a

    test "success", %{param: param, session: session, socket: socket} do
      assert {
               :ok,
               %Phoenix.LiveView.Socket{
                 assigns: %{__changed__: %{greeting: true}}
               }
             } = mount(param.valid, session.valid, socket.valid)
    end
  end

  describe "render/1" do
    setup ~w[c_assigns_greeting c_resp_body_hello c_resp_body_to_html]a

    test "Protocol.UndefinedError", %{assigns: assigns} do
      assert_raise Protocol.UndefinedError, fn ->
        render_component(Hello, assigns.invalid)
      end
    end

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert render_component(Hello, assigns.valid) =~ resp_body
    end
  end
end
