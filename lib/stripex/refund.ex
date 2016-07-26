defmodule Stripex.Refund do
  use Stripex.API, [:create, :retrieve, :update, :list]

  def endpoint do
    "refunds"
  end
end
