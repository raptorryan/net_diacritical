defmodule NetDiacriticalWeb.TXT.PageTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.TXT

  alias TXT.Page

  describe "__mix_recompile__?/0" do
    import Page, only: [__mix_recompile__?: 0]

    test "failure" do
      refute __mix_recompile__?()
    end
  end

  describe "hello/1" do
    import Page, only: [hello: 1]

    setup [:c_assigns_greeting, :c_resp_body_hello]

    test "FunctionClauseError", %{assigns: assigns} do
      assert_raise FunctionClauseError, fn -> hello(assigns.invalid) end
    end

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(Page, :hello, 1)
      assert hello(assigns.valid) == resp_body
    end
  end
end
