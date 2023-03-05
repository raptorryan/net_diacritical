defmodule NetDiacriticalWeb.TXT do
  @moduledoc "Defines commonalities for `Phoenix.Template` templates."
  @moduledoc since: "0.2.0"

  alias NetDiacriticalWeb, as: Web

  alias Web.{Endpoint, Router}

  @doc """
  Compiles a function for each template in the given `pattern`.

  ## Option

    * `:root` - The template root directory. If a directory is not given, it
      will, by default, be the module’s current directory, `__DIR__`.

  """
  @doc since: "0.2.0"
  defmacro embed_templates(pattern, opt \\ [])
           when is_binary(pattern) and is_list(opt) do
    quote do
      require Phoenix.Template

      Phoenix.Template.compile_all(
        &(&1 |> Path.basename() |> Path.rootname(".txt.eex")),
        Path.expand(unquote(opt)[:root] || __DIR__, __DIR__),
        unquote(pattern) <> ".txt"
      )
    end
  end

  @doc """
  In `use`, calls `import unquote(__MODULE__)` to import common functions.

  ## Example

      iex> defmodule TestTemplate do
      ...>   use NetDiacriticalWeb.TXT
      ...>
      ...>   embed_templates "template/*",
      ...>     root: "../../support/net_diacritical_web/txt"
      ...> end
      iex>
      iex> %{assigns: %{valid: assigns}} = c_assigns_greeting()
      iex> %{resp_body: resp_body} = c_resp_body_hello()
      iex>
      iex> function_exported?(TestTemplate, :hello, 1)
      true
      iex> TestTemplate.hello(assigns)
      resp_body

  """
  @doc since: "0.2.0"
  defmacro __using__(opt) when is_list(opt) do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: Endpoint,
        router: Router,
        statics: Web.static_path()

      import unquote(__MODULE__)
    end
  end
end
