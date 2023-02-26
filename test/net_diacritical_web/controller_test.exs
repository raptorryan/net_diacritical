defmodule NetDiacriticalWeb.ControllerTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.2.0"

  use NetDiacriticalCase.Conn, async: true

  alias NetDiacriticalWeb, as: Web

  alias Web.Controller

  doctest Controller
end
