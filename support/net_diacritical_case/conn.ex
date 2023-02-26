defmodule NetDiacriticalCase.Conn do
  @moduledoc "Defines an `ExUnit.CaseTemplate` case template."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase

  alias NetDiacriticalCase, as: Case

  @typedoc "Represents the current context."
  @typedoc since: "0.2.0"
  @type context() :: Case.context()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.2.0"
  @type context_merge() :: Case.context_merge()

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conn: _conn} = c_conn()

  """
  @doc since: "0.2.0"
  @spec c_conn() :: context_merge()
  @spec c_conn(context()) :: context_merge()
  def c_conn(c \\ %{request_path: "/"}) when is_map(c) do
    %{
      conn: %{
        invalid: %{},
        valid:
          Phoenix.ConnTest.build_conn(
            :get,
            c[:uri][:string] || c[:request_path]
          )
      }
    }
  end

  using do
    quote do
      import unquote(__MODULE__)
      import NetDiacriticalCase.View
      import Phoenix.ConnTest

      @endpoint Endpoint
    end
  end
end
