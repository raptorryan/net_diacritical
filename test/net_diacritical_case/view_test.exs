defmodule NetDiacriticalCase.ViewTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.Template, async: true

  alias NetDiacriticalCase, as: Case

  alias Case.View

  doctest View, import: true

  describe "__ex_unit__/2" do
    setup :c_context

    test ":setup", %{context: context} do
      assert View.__ex_unit__(:setup, context.valid) == context.valid
    end

    test ":setup_all", %{context: context} do
      assert View.__ex_unit__(:setup_all, context.valid) == context.valid
    end
  end

  describe "c_assigns_empty/0" do
    import View, only: [c_assigns_empty: 0]

    test "success" do
      assert %{assigns: _assigns} = c_assigns_empty()
    end
  end

  describe "c_assigns_empty/1" do
    import View, only: [c_assigns_empty: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_assigns_empty(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{assigns: _assigns} = c_assigns_empty(context.valid)
    end
  end

  describe "c_assigns_greeting/0" do
    import View, only: [c_assigns_greeting: 0]

    test "success" do
      assert %{assigns: _assigns} = c_assigns_greeting()
    end
  end

  describe "c_assigns_greeting/1" do
    import View, only: [c_assigns_greeting: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_assigns_greeting(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{assigns: _assigns} = c_assigns_greeting(context.valid)
    end
  end

  describe "c_resp_body_404/0" do
    import View, only: [c_resp_body_404: 0]

    test "success" do
      assert %{resp_body: _resp_body} = c_resp_body_404()
    end
  end

  describe "c_resp_body_404/1" do
    import View, only: [c_resp_body_404: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_resp_body_404(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{resp_body: _resp_body} = c_resp_body_404(context.valid)
    end
  end

  describe "c_resp_body_500/0" do
    import View, only: [c_resp_body_500: 0]

    test "success" do
      assert %{resp_body: _resp_body} = c_resp_body_500()
    end
  end

  describe "c_resp_body_500/1" do
    import View, only: [c_resp_body_500: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_resp_body_500(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{resp_body: _resp_body} = c_resp_body_500(context.valid)
    end
  end

  describe "c_resp_body_goodbye/0" do
    import View, only: [c_resp_body_goodbye: 0]

    test "success" do
      assert %{resp_body: _resp_body} = c_resp_body_goodbye()
    end
  end

  describe "c_resp_body_goodbye/1" do
    import View, only: [c_resp_body_goodbye: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_resp_body_goodbye(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{resp_body: _resp_body} = c_resp_body_goodbye(context.valid)
    end
  end

  describe "c_resp_body_hello/0" do
    import View, only: [c_resp_body_hello: 0]

    test "success" do
      assert %{resp_body: _resp_body} = c_resp_body_hello()
    end
  end

  describe "c_resp_body_hello/1" do
    import View, only: [c_resp_body_hello: 1]

    setup :c_context

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_resp_body_hello(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{resp_body: _resp_body} = c_resp_body_hello(context.valid)
    end
  end

  describe "c_resp_body_to_html/1" do
    import View, only: [c_resp_body_to_html: 1]

    setup do
      %{context: %{invalid: %{resp_body: ~C""}, valid: %{resp_body: ""}}}
    end

    test "FunctionClauseError", %{context: context} do
      assert_raise FunctionClauseError, fn ->
        c_resp_body_to_html(context.invalid)
      end
    end

    test "success", %{context: context} do
      assert %{resp_body: _resp_body} = c_resp_body_to_html(context.valid)
    end
  end
end
