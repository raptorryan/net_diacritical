defmodule NetDiacriticalWeb.HTML.ErrorTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.HTML

  alias HTML.Error

  describe "__mix_recompile__?/0" do
    import Error, only: [__mix_recompile__?: 0]

    test "failure" do
      refute __mix_recompile__?()
    end
  end

  describe "404/1" do
    setup ~w[c_assigns_empty c_resp_body_404 c_resp_body_to_html]a

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(Error, :"404", 1)
      assert render_component(&Error."404"/1, assigns) == resp_body
    end
  end

  describe "500/1" do
    setup ~w[c_assigns_empty c_resp_body_500 c_resp_body_to_html]a

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(Error, :"500", 1)
      assert render_component(&Error."500"/1, assigns) == resp_body
    end
  end
end
