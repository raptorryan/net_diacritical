defmodule NetDiacriticalWeb.LiveViewTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.4.0"

  use NetDiacriticalCase.Conn, async: true

  alias NetDiacriticalCase, as: Case
  alias NetDiacriticalWeb, as: Web

  alias Web.{HTML, LiveView, Token}

  alias HTML.Layout

  @typedoc "Represents the current context."
  @typedoc since: "0.4.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.4.0"
  @type context_merge() :: Case.context_merge()

  @spec c_name_default(context()) :: context_merge()
  defp c_name_default(c) when is_map(c) do
    %{name: %{invalid: "default", valid: :default}}
  end

  @spec c_param(context()) :: context_merge()
  defp c_param(c) when is_map(c) do
    %{param: %{invalid: [], valid: %{}}}
  end

  @spec c_session(context()) :: context_merge()
  defp c_session(c) when is_map(c) do
    %{session: %{invalid: [], valid: %{}}}
  end

  @spec c_socket_csp_nonce(context()) :: context_merge()
  defp c_socket_csp_nonce(%{}) do
    nonce =
      18
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64()

    signed = %Phoenix.LiveView.Socket{
      private: %{connect_params: %{"_csp_token" => Token.sign(nonce)}},
      transport_pid: self()
    }

    unsigned = %Phoenix.LiveView.Socket{
      private: %{connect_params: %{"_csp_token" => nonce}},
      transport_pid: self()
    }

    %{
      socket: %{
        assigned: %Phoenix.LiveView.Socket{assigns: %{nonce: nonce}},
        halted: %Phoenix.LiveView.Socket{
          unsigned
          | redirected: {:redirect, %{to: "/hello"}}
        },
        invalid: %{},
        mounted: %Phoenix.LiveView.Socket{
          signed
          | assigns: %{__changed__: %{nonce: true}, nonce: nonce}
        },
        signed: signed,
        unsigned: unsigned
      }
    }
  end

  doctest LiveView, import: true

  describe "on_mount/4" do
    import LiveView, only: [on_mount: 4]

    setup ~w[c_name_default c_param c_session c_socket_csp_nonce]a

    test "FunctionClauseError", %{
      name: name,
      param: param,
      session: session,
      socket: socket
    } do
      assert_raise FunctionClauseError, fn ->
        on_mount(name.invalid, param.valid, session.valid, socket.signed)
      end

      assert_raise FunctionClauseError, fn ->
        on_mount(name.valid, param.invalid, session.valid, socket.signed)
      end

      assert_raise FunctionClauseError, fn ->
        on_mount(name.valid, param.valid, session.invalid, socket.signed)
      end

      assert_raise FunctionClauseError, fn ->
        on_mount(name.valid, param.valid, session.valid, socket.invalid)
      end
    end

    test "unsigned", %{
      name: name,
      param: param,
      session: session,
      socket: socket
    } do
      assert on_mount(
               name.valid,
               param.valid,
               session.valid,
               socket.unsigned
             ) == {:halt, socket.halted}
    end

    test "signed", %{
      name: name,
      param: param,
      session: session,
      socket: socket
    } do
      assert on_mount(name.valid, param.valid, session.valid, socket.signed) ==
               {:cont, socket.mounted}
    end

    test "assigned", %{
      name: name,
      param: param,
      session: session,
      socket: socket
    } do
      assert on_mount(
               name.valid,
               param.valid,
               session.valid,
               socket.assigned
             ) == {:cont, socket.assigned}
    end
  end
end
