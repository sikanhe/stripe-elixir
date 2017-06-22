defmodule Stripe.Invoice do
  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(invoice_id \\ "") do
    "invoices/#{invoice_id}"
  end

  @spec line_items(Enum.t) :: Stripe.Request.t
  def line_items(%{"id" => invoice_id}) do
    line_items(invoice_id)
  end
  
  @spec retrieve_line_items(binary, Enum.t) :: Stripe.Request.t
  def line_items(invoice_id, pagination_opts \\ []) do
    %Stripe.Request{
      method: :get,
      endpoint: "#{endpoint(invoice_id)}/lines",
      params: pagination_opts
    }
  end

  @spec upcoming(Enum.t) :: Stripe.Request.t
  def upcoming(params) do
    %Stripe.Request{
      method: :get,
      endpoint: "#{endpoint()}/upcoming",
      params: params
    }
  end

  @spec pay(binary) :: Stripe.Request.t
  def pay(invoice_id) do
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint(invoice_id)}/pay"
    }
  end
end
