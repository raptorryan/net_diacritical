defmodule NetDiacriticalWeb.HTML.LayoutTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalCase, as: Web
  alias NetDiacriticalWeb, as: Web

  alias Web.HTML

  alias HTML.Layout

  @typedoc "Represents the current context."
  @typedoc since: "0.3.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.3.0"
  @type context_merge() :: Case.context_merge()

  @spec c_assigns_inner_content(context()) :: context_merge()
  defp c_assigns_inner_content(c) when is_map(c) do
    %{assigns: %{invalid: {}, valid: %{inner_content: ""}}}
  end

  describe "__mix_recompile__?/0" do
    import Layout, only: [__mix_recompile__?: 0]

    test "failure" do
      refute __mix_recompile__?()
    end
  end

  describe "__phoenix_verify_routes__/1" do
    import Layout, only: [__phoenix_verify_routes__: 1]

    test "success" do
      assert __phoenix_verify_routes__(Layout) == :ok
    end
  end

  describe "app/1" do
    import Layout, only: [app: 1]

    setup :c_assigns_inner_content

    test "FunctionClauseError", %{assigns: assigns} do
      assert_raise FunctionClauseError, fn -> app(assigns.invalid) end
    end

    test "success", %{assigns: assigns} do
      assert function_exported?(Layout, :app, 1)
      assert assigns.valid |> app() |> safe_to_string() =~ "<main>"
    end
  end

  describe "root/1" do
    import Layout, only: [root: 1]

    setup :c_assigns_inner_content

    test "FunctionClauseError", %{assigns: assigns} do
      assert_raise FunctionClauseError, fn -> root(assigns.invalid) end
    end

    test "success", %{assigns: assigns} do
      assert function_exported?(Layout, :app, 1)
      assert assigns.valid |> root() |> safe_to_string() =~ "<!DOCTYPE html>"
    end
  end
end
