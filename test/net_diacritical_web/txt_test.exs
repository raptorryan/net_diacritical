defmodule NetDiacriticalWeb.TXTTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.TXT

  doctest TXT

  describe "embed_templates/1" do
    import TXT, only: [embed_templates: 1]

    embed_templates "../../support/net_diacritical_web/txt/template/hello"

    setup [:c_assigns_greeting, :c_resp_body_hello]

    test "CompileError" do
      refute function_exported?(__MODULE__, :silence, 1)
    end

    test "FunctionClauseError", %{assigns: assigns} do
      assert_raise FunctionClauseError, fn -> hello(assigns.invalid) end
    end

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(__MODULE__, :hello, 1)
      assert hello(assigns.valid) == resp_body
    end
  end

  describe "embed_templates/2" do
    import TXT, only: [embed_templates: 2]

    embed_templates "template/goodbye",
      root: "../../support/net_diacritical_web/txt"

    setup :c_assigns_greeting

    test "CompileError" do
      refute function_exported?(__MODULE__, :silence, 1)
    end

    test "FunctionClauseError", %{assigns: assigns} do
      assert_raise FunctionClauseError, fn -> goodbye(assigns.invalid) end
    end

    test "success", %{assigns: assigns} do
      assert function_exported?(__MODULE__, :goodbye, 1)
      assert goodbye(assigns.valid) == "Goodbye, world!\n"
    end
  end
end
