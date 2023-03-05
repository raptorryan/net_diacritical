defmodule NetDiacriticalWeb.Token do
  @moduledoc "Defines a `Phoenix.Token` wrapper."
  @moduledoc since: "0.5.0"

  alias NetDiacriticalWeb, as: Web

  alias Web.Endpoint

  @typedoc "Represents the data."
  @typedoc since: "0.3.0"
  @type data() :: term()

  @typedoc "Represents the token."
  @typedoc since: "0.3.0"
  @type token() :: binary()

  @typedoc "Represents the potential token."
  @typedoc since: "0.3.0"
  @type token?() :: token() | nil

  @typedoc "Represents the error given by the verification."
  @typedoc since: "0.3.0"
  @type verify_err() :: :expired | :invalid | :missing

  @typedoc "Represents the verification."
  @typedoc since: "0.3.0"
  @type verify() :: {:ok, data()} | {:error, verify_err()}

  @namespace "net_diacritical"

  @doc """
  Encodes and signs the given `data` into a bearer token.

  ## Example

      iex> "SFMyNTY" <> _token = sign(%{id: :rand.uniform(1_000)})

  """
  @doc since: "0.3.0"
  @spec sign(data()) :: token()
  def sign(data) do
    Phoenix.Token.sign(Endpoint, @namespace, data)
  end

  @doc """
  Decodes the original data from a given `token` and verifies its integrity.

  ## Examples

      iex> id = :rand.uniform(1_000)
      iex> opt = [signed_at: System.system_time(:second) - 604_800]
      iex> token =
      ...>   Phoenix.Token.sign(Endpoint, "net_diacritical", %{id: id}, opt)
      iex>
      iex> verify(token)
      {:error, :expired}

      iex> verify("")
      {:error, :invalid}

      iex> verify(nil)
      {:error, :missing}

      iex> id = :rand.uniform(1_000)
      iex> token = Phoenix.Token.sign(Endpoint, "net_diacritical", %{id: id})
      iex>
      iex> verify(token)
      {:ok, %{id: id}}

  """
  @doc since: "0.3.0"
  @spec verify(token?()) :: verify()
  def verify(token?) when is_binary(token?) or is_nil(token?) do
    Phoenix.Token.verify(Endpoint, @namespace, token?)
  end
end
