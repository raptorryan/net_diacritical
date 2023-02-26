defmodule NetDiacriticalWeb.TXT.ErrorTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.View, async: true

  alias NetDiacriticalCase, as: Case
  alias NetDiacriticalWeb, as: Web

  alias Web.TXT

  alias TXT.Error

  @typedoc "Represents the current context."
  @typedoc since: "0.2.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.2.0"
  @type context_merge() :: Case.context_merge()

  @spec c_assigns_empty(context()) :: context_merge()
  defp c_assigns_empty(c) when is_map(c) do
    %{assigns: []}
  end

  describe "__mix_recompile__?/0" do
    import Error, only: [__mix_recompile__?: 0]

    test "failure" do
      refute __mix_recompile__?()
    end
  end

  describe "404/1" do
    setup :c_assigns_empty

    test "success", %{assigns: assigns} do
      assert function_exported?(Error, :"404", 1)
      assert Error."404"(assigns) == "Not Found\n"
    end
  end

  describe "500/1" do
    setup :c_assigns_empty

    test "success", %{assigns: assigns} do
      assert function_exported?(Error, :"500", 1)
      assert Error."500"(assigns) == "Internal Server Error\n"
    end
  end
end
