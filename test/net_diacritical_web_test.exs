defmodule NetDiacriticalWebTest do
  @moduledoc "Defines an `ExUnit.Case` case."
  @moduledoc since: "0.3.0"

  use ExUnit.Case, async: true

  alias NetDiacriticalWeb, as: Web

  doctest Web, import: true

  describe "static_path/0" do
    import Web, only: [static_path: 0]

    test "success" do
      assert static_path() == ~w[asset favicon.ico robots.txt]
    end
  end
end
