defmodule Stripex.Balance do
  use Stripex.API, [:list]

  def endpoint do
    "balance"
  end

  def retrieve do
    list
  end
end
