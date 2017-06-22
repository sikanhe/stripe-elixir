# Stripe [![Build Status](https://semaphoreci.com/api/v1/sikanhe/stripe-elixir/branches/master/badge.svg)](https://semaphoreci.com/sikanhe/stripe-elixir) #

Stripe API client for Elixir. [Documentation](https://hexdocs.pm/stripe_elixir/api-reference.html)
- Everything except for Relay features are complete and tested.
- Looking for more contributors/maintainers for this project, currently need help with documentation.

## Installation

  1. Add `stripe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:stripe, "~> 0.7.0", hex: :stripe_elixir}]
end
```

  2. (Pre-Elixir 1.4) Ensure `stripe` is started before your application:

```elixir
def application do
  [applications: [:stripe]]
end
```

  3. Make sure your stripe secret_key is added to your config file:

```elixir
config :stripe, :secret_key, <YOUR_SECRET_KEY>
```

  4. Alternatively, you can also set the secret key as an environment variable:

```bash
export STRIPE_SECRET_KEY=<YOUR_SECRET_KEY>
```

## Basic Usage

This lib closely follows the official Ruby Client API.

`Stripe.{RESOURCE}.create`
`Stripe.{RESOURCE}.retrieve`
`Stripe.{RESOURCE}.update`
`Stripe.{RESOURCE}.list`

Returns {:ok, RESPONSE_BODY} when the request is successful.

{:error, %ERROR_STRUCT{}} tuples are returned when there is a request/api error
See all error types at https://stripe.com/docs/api/ruby#errors

## Some Basic Examples
Create a customer

```elixir
{:ok, %{"id" => "cus_asdfghjkl"} =
    Stripe.Customer.create(email: "example@gmail.com")
```

Note that either KeywordLists or Maps with either String or Atom keys are acceptable for arguments and options. So all of the following would also work:


```elixir
Stripe.Customer.create(%{email: "example@gmail.com"})
Stripe.Customer.create(%{"email" => "example@gmail.com"})
Stripe.Customer.create([{"email", "example@gmail.com"}])
```

Retrieve that customer:
```elixir   
{:ok, customer} = Stripe.Customer.retrieve("cus_asdfghjkl")
```

Update the customer:
```elixir
{:ok, %{"metadata" => %{"somedata" => "somevalue"}}} =
  Stripe.Customer.update("cus_asdfghjkl", metadata: [somedata: "somevalue"])
```

Delete the customer

```elixir
{:ok, %{"deleted" => true}} = Stripe.Customer.delete("cus_asdfghjkl")
```

## Stripe Connect

To perform a Direct Charge on a connected stripe account, simply pass :stripe_account as an option

```elixir
Stripe.Charge.create([customer: "cus_asdfghjkl", amount: 400], stripe_account: "acct_sOMeAcCountId")
```

#### Generate a Connect authorization url via `Stripe.Connect.authorize_url/1`. 

```elixir 
Stripe.Connect.authorize_url([
  redirect_uri: <OPTIONAL CALLBACK URL>,
  state: <OPTIONAL CSRF TOKEN>,
  client_id: <OPTIONAL STRIPE PLATFORM CLIENT ID>
])
```

#### Options: 
- `redirect_uri`: An optional callback url after authorization succeeds. 
- `state`: You can protect your request from CSRF attacks by passing a csrf token.
- `client_id`: You can pass in an optional client_id to be used for this url. Defaults to `STRIPE_CLIENT_ID` environment variable or `config :stripe, :client_id` config value. 


## Handling Webhooks

Stripe uses webhooks to notify your web app with events. `Stripe.Webhook` provides `construct_event/3` to authenticate the requests, which can be useful in plugs.

```elixir
payload = # HTTP content body (e.g. from Plug.Conn.read_body/3)
signature = # 'Stripe-Signature' HTTP header (e.g. from Plug.Conn.get_req_header/2)
secret = # Provided by Stripe

case Stripe.Webhook.construct_event(payload, signature, secret) do
  {:ok, event} ->
    # Return 2XX
  {:error, %Stripe.SignatureVerificationError{}} ->
    # Return non-2XX and handle error
end
```

The default tolerance is 5 minutes (300 seconds as per official libraries). If your app is rejecting requests because the tolerance is too low, consider passing a higher number to `construct_event/4`.

```elixir
Stripe.Webhook.construct_event(payload, signature, secret, 600)
```
