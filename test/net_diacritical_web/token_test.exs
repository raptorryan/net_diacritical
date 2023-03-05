defmodule NetDiacriticalWeb.TokenTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use ExUnit.Case, async: true

  alias NetDiacriticalCase, as: Case
  alias NetDiacriticalWeb, as: Web

  alias Web.{Endpoint, Token}

  @typedoc "Represents the current context."
  @typedoc since: "0.3.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.3.0"
  @type context_merge() :: Case.context_merge()

  @spec c_data(context()) :: context_merge()
  defp c_data(c) when is_map(c) do
    %{data: %{id: :rand.uniform(1_000)}}
  end

  doctest Token, import: true

  describe "sign/1" do
    import Token, only: [sign: 1]

    setup :c_data

    setup do
      %{pref: "SFMyNTY"}
    end

    test "success", %{data: data, pref: pref} do
      assert sign(data) =~ pref
    end
  end

  describe "verify/1" do
    import Token, only: [verify: 1]

    setup :c_data

    setup %{data: data} do
      %{
        token: %{
          invalid: '',
          expired:
            Phoenix.Token.sign(
              Endpoint,
              "net_diacritical",
              data,
              signed_at: System.system_time(:second) - 604_800
            ),
          missing: nil,
          unsigned: "",
          valid: Phoenix.Token.sign(Endpoint, "net_diacritical", data)
        }
      }
    end

    test "FunctionClauseError", %{token: token} do
      assert_raise FunctionClauseError, fn -> verify(token.invalid) end
    end

    test "expired", %{token: token} do
      assert verify(token.expired) == {:error, :expired}
    end

    test "invalid", %{token: token} do
      assert verify(token.unsigned) == {:error, :invalid}
    end

    test "missing", %{token: token} do
      assert verify(token.missing) == {:error, :missing}
    end

    test "success", %{data: data, token: token} do
      assert verify(token.valid) == {:ok, data}
    end
  end
end
