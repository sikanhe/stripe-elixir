defmodule Stripex.CountrySpec do
  use Stripex.API, [:retrieve, :list]

  def endpoint do
    "country_specs"
  end
end
