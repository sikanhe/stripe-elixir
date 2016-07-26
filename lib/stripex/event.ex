defmodule Stripex.Event do
  use Stripex.API, [:retrieve, :list]

  def endpoint do
    "events"
  end
end
