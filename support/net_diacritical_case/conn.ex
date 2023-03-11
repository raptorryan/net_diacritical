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

      iex> %{action: _action} = c_action_hello()

  """
  @doc since: "0.2.0"
  @spec c_action_hello() :: context_merge()
  @spec c_action_hello(context()) :: context_merge()
  def c_action_hello(c \\ %{}) when is_map(c) do
    %{action: %{invalid: "hello", valid: :hello}}
  end

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

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conn: _conn} = c_conn_format_txt(%{conn: %{valid: %Plug.Conn{}}})

  """
  @doc since: "0.2.0"
  @spec c_conn_format_txt(context()) :: context_merge()
  def c_conn_format_txt(%{conn: %{valid: %Plug.Conn{} = conn} = c}) do
    %{conn: %{c | valid: Phoenix.Controller.put_format(conn, "txt")}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{conn: _conn} = c_conn_script_name(%{conn: %{invalid: %{}}})

  """
  @doc since: "0.2.0"
  @spec c_conn_script_name(context()) :: context_merge()
  def c_conn_script_name(%{conn: %{invalid: conn} = c}) when is_map(conn) do
    %{conn: %{c | invalid: Map.merge(conn, %{script_name: nil})}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{opt: _opt} = c_opt()

  """
  @doc since: "0.2.0"
  @spec c_opt() :: context_merge()
  @spec c_opt(context()) :: context_merge()
  def c_opt(c \\ %{}) when is_map(c) do
    %{opt: []}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{param: _param} = c_param()

  """
  @doc since: "0.3.0"
  @spec c_param() :: context_merge()
  @spec c_param(context()) :: context_merge()
  def c_param(c \\ %{}) when is_map(c) do
    %{param: %{invalid: [], valid: %{}}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{request_path: _request_path} = c_request_path_hello()

  """
  @doc since: "0.2.0"
  @spec c_request_path_hello() :: context_merge()
  @spec c_request_path_hello(context()) :: context_merge()
  def c_request_path_hello(c \\ %{}) when is_map(c) do
    %{request_path: "/hello"}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{session: _session} = c_session()

  """
  @doc since: "0.4.0"
  @spec c_session() :: context_merge()
  @spec c_session(context()) :: context_merge()
  def c_session(c \\ %{}) when is_map(c) do
    %{session: %{invalid: [], valid: %{}}}
  end

  @doc """
  Defines a map of fixtures to be merged into an `ExUnit` context.

  ## Example

      iex> %{status: _status} = c_status_ok()

  """
  @doc since: "0.2.0"
  @spec c_status_ok() :: context_merge()
  @spec c_status_ok(context()) :: context_merge()
  def c_status_ok(c \\ %{}) when is_map(c) do
    %{status: %{ok: 200}}
  end

  using do
    quote do
      import unquote(__MODULE__)
      import NetDiacriticalCase.View
      import Phoenix.{ConnTest, LiveViewTest}

      @endpoint Endpoint
    end
  end
end
