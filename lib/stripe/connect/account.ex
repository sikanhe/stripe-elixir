defmodule Stripe.Account do
  use Stripe.API, [:create, :retrieve, :update, :list, :delete]

  def endpoint, do: "accounts"

  def reject(account_id, reason: reason) do
    Stripe.request(:post, "#{endpoint()}/#{account_id}/reject", reason: reason)
  end

  def external_account_endpoint(account_id, external_account_id \\ "") do 
    "#{endpoint()}/#{account_id}/external_accounts/#{external_account_id}"
  end 

  def create_external_account(account_id, external_account: token_id) do
    url = external_account_endpoint(account_id)
    Stripe.request(:post, url, external_account: token_id)
  end

  def retrieve_external_account(account_id, external_account_id) do
    url = external_account_endpoint(account_id, external_account_id)
    Stripe.request(:get, url)
  end

  def update_external_account(account_id, external_account_id, updates) do
    url = external_account_endpoint(account_id, external_account_id)
    Stripe.request(:post, url, updates)
  end

  def delete_external_account(account_id, external_account_id) do
    url = external_account_endpoint(account_id, external_account_id)
    Stripe.request(:delete, url)
  end

  def list_external_account(account_id, pagination_opts \\ []) do
    url = external_account_endpoint(account_id)
    Stripe.request(:get, url, pagination_opts)
  end
end
