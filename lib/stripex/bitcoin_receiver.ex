defmodule Stripex.BitcoinReceiver do
  use Stripex.API, [:create, :retrieve, :list]

  def endpoint do
    "bitcoin/receivers"
  end
end
