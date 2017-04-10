defmodule Stripe.Customer do
  use Stripe.API, [:retrieve, :update, :create, :list, :delete]

  def endpoint do
    "/customers"
  end

  # discount

  def delete_discount(customer_id) do
    Stripe.request(:delete, "#{endpoint}/#{customer_id}/discount")
  end

  # sources

  def retrieve_source(customer_id, source_id) do
    Stripe.request(:get, "#{endpoint}/#{customer_id}/sources/#{source_id}")
  end

  def update_source(customer_id, source_id, updates) do
    Stripe.request(:post, "#{endpoint}/#{customer_id}/sources/#{source_id}", updates)
  end

  def create_source(customer_id, source: token_or_dict) do
    Stripe.request(:post, "#{endpoint}/#{customer_id}/sources", [source: token_or_dict])
  end

  def delete_source(customer_id, source: token_or_dict) do
    Stripe.request(:delete, "#{endpoint}/#{customer_id}/sources/#{token_or_dict}")
  end

  # card

  def create_card(customer_id, card_id) do
    create_source(customer_id, source: card_id)
  end

  def update_card(customer_id, card_id, updates) do
    update_source(customer_id, card_id, updates)
  end

  def delete_card(customer_id, card_id) do
    delete_source(customer_id, source: card_id)
  end

  # bank_account

  def create_bank_account(customer_id, bank_acct_id) do
    create_source(customer_id, source: bank_acct_id)
  end

  def update_bank_account(customer_id, bank_acct_id, updates) do
    update_source(customer_id, bank_acct_id, updates)
  end

  def delete_bank_account(customer_id, bank_acct_id) do
    delete_source(customer_id, source: bank_acct_id)
  end
end
