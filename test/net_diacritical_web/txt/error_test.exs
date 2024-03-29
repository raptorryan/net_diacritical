defmodule NetDiacriticalWeb.TXT.ErrorTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.TXT

  alias TXT.Error

  describe "__mix_recompile__?/0" do
    import Error, only: [__mix_recompile__?: 0]

    test "failure" do
      refute __mix_recompile__?()
    end
  end

  describe "404/1" do
    setup [:c_assigns_empty, :c_resp_body_404]

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(Error, :"404", 1)
      assert Error."404"(assigns) == resp_body
    end
  end

  describe "500/1" do
    setup [:c_assigns_empty, :c_resp_body_500]

    test "success", %{assigns: assigns, resp_body: resp_body} do
      assert function_exported?(Error, :"500", 1)
      assert Error."500"(assigns) == resp_body
    end
  end
end
