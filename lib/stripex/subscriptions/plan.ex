defmodule Stripex.Plan do
  use Stripex.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "plans"
  end
end
