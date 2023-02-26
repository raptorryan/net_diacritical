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
end
