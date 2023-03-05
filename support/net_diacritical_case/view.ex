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

      iex> %{assigns: _assigns} = c_assigns_empty()

  """
  @doc since: "0.3.0"
  @spec c_assigns_empty() :: context_merge()
  @spec c_assigns_empty(context()) :: context_merge()
  def c_assigns_empty(c \\ %{}) when is_map(c) do
    %{assigns: []}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{assigns: _assigns} = c_assigns_greeting()

  """
  @doc since: "0.2.0"
  @spec c_assigns_greeting() :: context_merge()
  @spec c_assigns_greeting(context()) :: context_merge()
  def c_assigns_greeting(c \\ %{}) when is_map(c) do
    %{assigns: %{invalid: {}, valid: [greeting: Core.greet()]}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{resp_body: _resp_body} = c_resp_body_404()

  """
  @doc since: "0.3.0"
  @spec c_resp_body_404() :: context_merge()
  @spec c_resp_body_404(context()) :: context_merge()
  def c_resp_body_404(c \\ %{}) when is_map(c) do
    %{resp_body: "Not Found\n"}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{resp_body: _resp_body} = c_resp_body_500()

  """
  @doc since: "0.3.0"
  @spec c_resp_body_500() :: context_merge()
  @spec c_resp_body_500(context()) :: context_merge()
  def c_resp_body_500(c \\ %{}) when is_map(c) do
    %{resp_body: "Internal Server Error\n"}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{resp_body: _resp_body} = c_resp_body_goodbye()

  """
  @doc since: "0.3.0"
  @spec c_resp_body_goodbye() :: context_merge()
  @spec c_resp_body_goodbye(context()) :: context_merge()
  def c_resp_body_goodbye(c \\ %{}) when is_map(c) do
    %{resp_body: "Goodbye, world!\n"}
  end

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

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{resp_body: _resp_body} = c_resp_body_to_html(%{resp_body: ""})

  """
  @doc since: "0.3.0"
  @spec c_resp_body_to_html(context()) :: context_merge()
  def c_resp_body_to_html(%{resp_body: resp_body}) when is_binary(resp_body) do
    %{resp_body: {:safe, ["<span>", String.trim(resp_body), "</span>\n"]}}
  end

  using do
    quote do
      import unquote(__MODULE__)
      import Phoenix.HTML, only: [safe_to_string: 1]
    end
  end
end
