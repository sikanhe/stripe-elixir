defmodule Stripex.Recipient do
  use Stripex.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "recipients"
  end
end
