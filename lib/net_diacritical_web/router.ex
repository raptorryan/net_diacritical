defmodule NetDiacriticalWeb.Router do
  @moduledoc "Defines a `Phoenix.Router` router."
  @moduledoc since: "0.2.0"

  use Phoenix.Router, helpers: false

  alias NetDiacriticalWeb, as: Web

  alias Web.Controller

  pipeline :plaintext do
    plug :accepts, ["txt", "text"]
  end

  scope "/" do
    pipe_through :plaintext

    get "/hello", Controller.Page, :hello
  end
end
