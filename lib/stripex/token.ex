defmodule Stripex.Token do
  use Stripex.API, [:create, :retrieve]

  def endpoint do
    "tokens"
  end
end
