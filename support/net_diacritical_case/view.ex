defmodule NetDiacriticalCase.View do
  @moduledoc "Defines an `ExUnit.CaseTemplate` case template."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase

  alias NetDiacritical, as: Core
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

      iex> %{resp_body: _resp_body} = c_resp_body_hello()

  """
  @doc since: "0.2.0"
  @spec c_resp_body_hello() :: context_merge()
  @spec c_resp_body_hello(context()) :: context_merge()
  def c_resp_body_hello(c \\ %{}) when is_map(c) do
    %{resp_body: Core.greet() <> "\n"}
  end

  using do
    quote do
      import unquote(__MODULE__)
    end
  end
end
