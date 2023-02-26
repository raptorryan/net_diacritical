defmodule NetDiacriticalCase do
  @moduledoc "Defines commonalities for `ExUnit.CaseTemplate` case templates."
  @moduledoc since: "0.1.0"

  use Boundary, deps: [ExUnit, NetDiacritical]

  @typedoc "Represents the current context."
  @typedoc since: "0.1.0"
  @type context() :: map()

  @typedoc "Represents the context merge value."
  @typedoc since: "0.1.0"
  @type context_merge() ::
          map() | Keyword.t() | {:ok, map() | Keyword.t()} | :ok

  @doc """
  In `use`, calls `use ExUnit.CaseTemplate`.

  ## Example

      iex> defmodule TestTemplate do
      ...>   use NetDiacriticalCase
      ...> end
      iex>
      iex> TestTemplate.__ex_unit__(:setup, %{})
      %{}
      iex> TestTemplate.__ex_unit__(:setup_all, %{})
      %{}

  """
  @doc since: "0.1.0"
  defmacro __using__(opt) do
    quote do
      use ExUnit.CaseTemplate, unquote(opt)
    end
  end
end
