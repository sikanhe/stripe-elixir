defmodule Stripex.Customer do
  use Stripex.API, [:retrieve, :create, :list, :delete]

  def endpoint do
    "/customers"
  end

  def delete_discount(customer_id) do
    Stripex.request(:delete, "#{endpoint}/#{customer_id}/discount")
  end

  def create_source(customer_id, source: token) do
    Stripex.request(:post, "#{endpoint}/#{customer_id}", [source: token])
  end

  def create_card(customer_id, card_id) do
    create_source(customer_id, source: card_id)
  end

  def delete_source(customer_id, source: token) do
    Stripex.request(:delete, "#{endpoint}/#{customer_id}/sources/#{token}")
  end

  def delete_card(customer_id, card_id) do
    delete_source(customer_id, source: card_id)
  end

  def retrieve_source(customer_id, source_id) do
    Stripex.request(:get, "#{endpoint}/#{customer_id}/sources/#{source_id}")
  end
end
