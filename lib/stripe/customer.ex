defmodule Stripe.Customer do
  use Stripe.API, [:retrieve, :update, :create, :list, :delete]

  def endpoint do
    "/customers"
  end

  # discount

  def delete_discount(customer_id, opts \\ []) do
    Stripe.request(:delete, "#{endpoint()}/#{customer_id}/discount", [], opts)
  end

  # sources

  def retrieve_source(customer_id, source_id, opts \\ []) do
    Stripe.request(:get, "#{endpoint()}/#{customer_id}/sources/#{source_id}", [], opts)
  end

  def update_source(customer_id, source_id, updates, opts \\ []) do
    Stripe.request(:post, "#{endpoint()}/#{customer_id}/sources/#{source_id}", updates, opts)
  end

  def create_source(customer_id, data, opts \\ []) do
    Stripe.request(:post, "#{endpoint()}/#{customer_id}/sources", data, opts)
  end

  def delete_source(customer_id, data, opts \\ []) do
    Stripe.request(:delete, "#{endpoint()}/#{customer_id}/sources/#{data[:source]}", [], opts)
  end

  # card

  def create_card(customer_id, card_id, opts \\ []) do
    create_source(customer_id, [source: card_id], opts)
  end

  def update_card(customer_id, card_id, updates) do
    update_source(customer_id, card_id, updates)
  end

  def delete_card(customer_id, card_id, opts \\ []) do
    delete_source(customer_id, [source: card_id], opts)
  end

  def list_cards(customer_id, pagination_opts \\ [], opts \\ []) do
    pagination_opts = put_in(pagination_opts, [:object], "card")
    Stripe.request(:get, "#{endpoint()}/#{customer_id}/sources", pagination_opts, opts)
  end

  # bank_account

  def create_bank_account(customer_id, bank_acct_id, opts \\ []) do
    create_source(customer_id, [source: bank_acct_id], opts)
  end

  def update_bank_account(customer_id, bank_acct_id, updates, opts \\ []) do
    update_source(customer_id, bank_acct_id, updates, opts)
  end

  def delete_bank_account(customer_id, bank_acct_id, opts \\ []) do
    delete_source(customer_id, [source: bank_acct_id], opts)
  end

  def list_bank_accounts(customer_id, pagination_opts \\ [], opts \\ []) do
    pagination_opts = put_in(pagination_opts, [:object], "bank_account")
    Stripe.request(:get, "#{endpoint()}/#{customer_id}/sources", pagination_opts, opts)
  end

  def verify_bank_account(customer_id, bank_acct_id, amounts, opts \\ []) do
    Stripe.request(:post, "#{endpoint()}/#{customer_id}/sources/#{bank_acct_id}/verify", [amounts: amounts], opts)
  end
end
