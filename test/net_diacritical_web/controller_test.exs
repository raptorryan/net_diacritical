defmodule NetDiacriticalWeb.ControllerTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.Conn, async: true

  alias NetDiacriticalCase, as: Case
  alias NetDiacriticalWeb, as: Web

  alias Web.Controller

  @typedoc "Represents the current context."
  @typedoc since: "0.2.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.2.0"
  @type context_merge() :: Case.context_merge()

  @spec c_conn_format_txt(context()) :: context_merge()
  defp c_conn_format_txt(%{conn: %{valid: %Plug.Conn{} = conn} = c}) do
    %{conn: %{c | valid: Phoenix.Controller.put_format(conn, "txt")}}
  end

  @spec c_action_hello(context()) :: context_merge()
  defp c_action_hello(c) when is_map(c) do
    %{action: %{invalid: "hello", valid: :hello}}
  end

  doctest Controller
end
