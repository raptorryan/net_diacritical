defmodule NetDiacriticalWeb.HTMLTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.HTML

  doctest HTML

  describe "embed_templates/1" do
    import HTML, only: [embed_templates: 1]

    embed_templates "../../support/net_diacritical_web/html/template/hello"

    setup ~w[c_assigns_greeting c_resp_body_hello c_resp_body_to_html]a

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
    import HTML, only: [embed_templates: 2]

    embed_templates "template/goodbye",
      root: "../../support/net_diacritical_web/html"

    setup ~w[c_assigns_greeting c_resp_body_goodbye c_resp_body_to_html]a

    test "CompileError" do
      refute function_exported?(__MODULE__, :silence, 1)
    end

    test "FunctionClauseError", %{assigns: assigns} do
      assert_raise FunctionClauseError, fn -> goodbye(assigns.invalid) end
    end

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(__MODULE__, :goodbye, 1)
      assert goodbye(assigns.valid) == resp_body
    end
  end
end
