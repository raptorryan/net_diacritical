defmodule NetDiacriticalWeb.Controller.PageTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.Conn, async: true

  alias NetDiacriticalCase, as: Case
  alias NetDiacriticalWeb, as: Web

  alias Web.{Controller, TXT}

  alias Controller.Page

  @typedoc "Represents the current context."
  @typedoc since: "0.2.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.2.0"
  @type context_merge() :: Case.context_merge()

  @spec c_conn_view_page(context()) :: context_merge()
  defp c_conn_view_page(%{conn: %{valid: %Plug.Conn{} = conn} = c}) do
    %{conn: %{c | valid: Phoenix.Controller.put_view(conn, txt: TXT.Page)}}
  end

  doctest Page, import: true

  describe "init/1" do
    import Page, only: [init: 1]

    setup :c_opt

    test "success", %{opt: opt} do
      assert init(opt) == opt
    end
  end

  describe "call/2" do
    import Page, only: [call: 2]

    setup [
      :c_request_path_hello,
      :c_conn,
      :c_conn_format_txt,
      :c_action_hello,
      :c_status_ok,
      :c_resp_body_hello
    ]

    test "FunctionClauseError", %{action: action, conn: conn} do
      assert_raise FunctionClauseError, fn ->
        call(conn.invalid, action.valid)
      end

      assert_raise FunctionClauseError, fn ->
        call(conn.valid, action.invalid)
      end
    end

    test "success", %{
      action: action,
      conn: conn,
      resp_body: resp_body,
      status: status
    } do
      assert text_response(call(conn.valid, action.valid), status.ok) ==
               resp_body
    end
  end

  describe "action/2" do
    import Page, only: [action: 2]

    setup [
      :c_action_hello,
      :c_request_path_hello,
      :c_conn,
      :c_conn_format_txt,
      :c_conn_view_page,
      :c_opt,
      :c_status_ok,
      :c_resp_body_hello
    ]

    setup %{action: %{valid: action}, conn: %{valid: conn} = c} do
      %{
        conn: %{
          c
          | invalid: %{private: %{phoenix_action: action}},
            valid: Plug.Conn.put_private(conn, :phoenix_action, action)
        }
      }
    end

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn -> action(conn.invalid, opt) end
    end

    test "success", %{
      conn: conn,
      status: status,
      opt: opt,
      resp_body: resp_body
    } do
      assert text_response(action(conn.valid, opt), status.ok) == resp_body
    end
  end

  describe "hello/2" do
    import Page, only: [hello: 2]

    setup [
      :c_request_path_hello,
      :c_conn,
      :c_conn_format_txt,
      :c_conn_view_page,
      :c_opt,
      :c_status_ok,
      :c_resp_body_hello
    ]

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn -> hello(conn.invalid, opt) end
    end

    test "success", %{
      conn: conn,
      status: status,
      opt: opt,
      resp_body: resp_body
    } do
      assert text_response(hello(conn.valid, opt), status.ok) == resp_body
    end
  end
end
