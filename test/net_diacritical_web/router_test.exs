defmodule NetDiacriticalWeb.RouterTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use NetDiacriticalCase.Conn, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.{Controller, Router}

  alias Controller.Page

  describe "__routes__/0" do
    import Router, only: [__routes__: 0]

    test "success" do
      assert [%{path: _path, plug: _plug} | _route] = __routes__()
    end
  end

  describe "__checks__/0" do
    import Router, only: [__checks__: 0]

    test "success" do
      assert __checks__() == (&NetDiacriticalWeb.Controller.Page.init/1)
    end
  end

  describe "__helpers__/0" do
    import Router, only: [__helpers__: 0]

    test "success" do
      assert __helpers__() == nil
    end
  end

  describe "__match_route__/3" do
    import Router, only: [__match_route__: 3]

    test "success" do
      assert {_metadata, _prepare, _pipeline, {_plug, _opts}} =
               __match_route__(["hello"], "GET", [])
    end
  end

  describe "__forward__/1" do
    import Router, only: [__forward__: 1]

    test "success" do
      assert __forward__(Page) == nil
    end
  end

  describe "__verify_route__/1" do
    import Router, only: [__verify_route__: 1]

    test "success" do
      assert __verify_route__(["hello"]) == {nil, false}
    end
  end

  describe "plaintext/2" do
    import Router, only: [plaintext: 2]

    setup ~w[c_request_path_hello c_conn c_conn_format_txt c_opt]a

    test "Plug.Conn.WrapperError", %{conn: conn, opt: opt} do
      assert_raise Plug.Conn.WrapperError, fn ->
        plaintext(conn.invalid, opt)
      end
    end

    test "success", %{conn: conn, opt: opt} do
      assert plaintext(conn.valid, opt) == conn.valid
    end
  end

  describe "init/1" do
    import Router, only: [init: 1]

    setup :c_opt

    test "success", %{opt: opt} do
      assert init(opt) == opt
    end
  end

  describe "call/2" do
    import Router, only: [call: 2]

    setup [
      :c_request_path_hello,
      :c_conn,
      :c_conn_script_name,
      :c_opt,
      :c_status_ok,
      :c_resp_body_hello
    ]

    test "FunctionClauseError", %{conn: conn, opt: opt} do
      assert_raise FunctionClauseError, fn -> call(conn.invalid, opt) end
    end

    test "success", %{
      conn: conn,
      opt: opt,
      status: status,
      resp_body: resp_body
    } do
      assert text_response(call(conn.valid, opt), status.ok) == resp_body
    end
  end
end
