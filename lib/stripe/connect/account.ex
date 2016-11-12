defmodule Stripe.Account do
  use Stripe.API, [:create, :retrieve, :update, :list, :delete]

  def endpoint, do: "accounts"

  def reject(account_id, reason: reason) do
    Stripe.request(:post, "#{endpoint()}/#{account_id}/reject")
  end

  def createExternalAccount(account_id, external_account: token_id) do
    Stripe.request(
      :post,
      "#{endpoint()}/#{account_id}/external_accounts",
      external_account: token_id
    )
  end

  def retrieveExternalAccount(account_id, external_account_id) do
    Stripe.request(
      :get,
      "#{endpoint()}/#{account_id}/external_accounts/#{external_account_id}"
    )
  end

  def updateExternalAccount(account_id, external_account_id, updates) do
    Stripe.request(
      :post,
      "#{endpoint()}/#{account_id}/external_accounts/#{external_account_id}",
      updates
    )
  end

  def deleteExternalAccount(account_id, external_account_id) do
    Stripe.request(
      :delete,
      "#{endpoint()}/#{account_id}/external_accounts/#{external_account_id}"
    )
  end

  def listExternalAccount(account_id, opts \\ []) do
    Stripe.request(
      :get,
      "#{endpoint()}/#{account_id}/external_accounts",
      opts
    )
  end
end
