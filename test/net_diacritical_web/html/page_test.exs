defmodule NetDiacriticalWeb.HTML.PageTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.HTML

  alias HTML.Page

  describe "__mix_recompile__?/0" do
    import Page, only: [__mix_recompile__?: 0]

    test "failure" do
      refute __mix_recompile__?()
    end
  end

  describe "__phoenix_verify_routes__/1" do
    import Page, only: [__phoenix_verify_routes__: 1]

    test "success" do
      assert __phoenix_verify_routes__(Page) == :ok
    end
  end

  describe "hello/1" do
    import Page, only: [hello: 1]

    setup ~w[c_assigns_greeting c_resp_body_hello c_resp_body_to_html]a

    test "Protocol.UndefinedError", %{assigns: assigns} do
      assert_raise Protocol.UndefinedError, fn ->
        render_component(&hello/1, assigns.invalid)
      end
    end

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(Page, :hello, 1)
      assert render_component(&hello/1, assigns.valid) == resp_body
    end
  end
end
