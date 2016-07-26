defmodule Stripex.File do
  use Stripex.API, [:create, :retrieve, :list]

  def endpoint do
    "files"
  end
end
