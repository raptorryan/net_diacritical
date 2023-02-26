defmodule NetDiacriticalCase.ConnTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.Template, async: true

  alias NetDiacriticalCase, as: Case

  alias Case.Conn

  doctest Conn, import: true

  describe "__ex_unit__/2" do
    setup :c_context

    test ":setup", %{context: context} do
      assert Conn.__ex_unit__(:setup, context.valid) == context.valid
    end

    test ":setup_all", %{context: context} do
      assert Conn.__ex_unit__(:setup_all, context.valid) == context.valid
    end
  end

  describe "c_action_hello/0" do
    import Conn, only: [c_action_hello: 0]

    test "success" do
      assert %{action: _action} = c_action_hello()
    end
  end

  describe "c_action_hello/1" do
    import Conn, only: [c_action_hello: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_action_hello(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{action: _action} = c_action_hello(context.valid)
    end
  end

  describe "c_conn/0" do
    import Conn, only: [c_conn: 0]

    test "success" do
      assert %{conn: _conn} = c_conn()
    end
  end

  describe "c_conn/1" do
    import Conn, only: [c_conn: 1]

    setup do
      %{
        context: %{invalid: %{request_path: ~C"/"}, valid: %{request_path: "/"}}
      }
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_conn(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{conn: _conn} = c_conn(context.valid)
    end
  end

  describe "c_conn_format_txt/1" do
    import Conn, only: [c_conn_format_txt: 1]

    setup do
      %{
        context: %{
          invalid: %{conn: %{valid: %{}}},
          valid: %{conn: %{valid: %Plug.Conn{}}}
        }
      }
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_conn_format_txt(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{conn: _conn} = c_conn_format_txt(context.valid)
    end
  end

  describe "c_conn_script_name/1" do
    import Conn, only: [c_conn_script_name: 1]

    setup do
      %{context: %{invalid: %{conn: %{}}, valid: %{conn: %{invalid: %{}}}}}
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_conn_script_name(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{conn: _conn} = c_conn_script_name(context.valid)
    end
  end

  describe "c_request_path_hello/0" do
    import Conn, only: [c_request_path_hello: 0]

    test "success" do
      assert %{request_path: _request_path} = c_request_path_hello()
    end
  end

  describe "c_request_path_hello/1" do
    import Conn, only: [c_request_path_hello: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_request_path_hello(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{request_path: _request_path} =
               c_request_path_hello(context.valid)
    end
  end

  describe "c_opt/0" do
    import Conn, only: [c_opt: 0]

    test "success" do
      assert %{opt: _opt} = c_opt()
    end
  end

  describe "c_opt/1" do
    import Conn, only: [c_opt: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_opt(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{opt: _opt} = c_opt(context.valid)
    end
  end

  describe "c_status_ok/0" do
    import Conn, only: [c_status_ok: 0]

    test "success" do
      assert %{status: _status} = c_status_ok()
    end
  end

  describe "c_status_ok/1" do
    import Conn, only: [c_status_ok: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn -> c_status_ok(context.invalid) end
    end

    test "success", %{context: context} do
      assert %{status: _status} = c_status_ok(context.valid)
    end
  end
end
