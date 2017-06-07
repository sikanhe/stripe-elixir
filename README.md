# Stripe [![Build Status](https://semaphoreci.com/api/v1/sikanhe/stripe-elixir/branches/master/badge.svg)](https://semaphoreci.com/sikanhe/stripe-elixir) #

Stripe API client for Elixir. [Documentation](https://hexdocs.pm/stripe_elixir/api-reference.html)
- Everything except for Relay features are complete and tested.
- Looking for more contributors/maintainers for this project, currently need help with documentation.

## Installation

  1. Add `stripe` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:stripe, "~> 0.5.0", hex: :stripe_elixir}]
    end
    ```

  2. Ensure `stripe` is started before your application:

    ```elixir
    def application do
      [applications: [:stripe]]
    end
    ```

  3. Make sure your stripe secret_key is added to your config file:

    ```elixir
    config :stripe, secret_key: YOUR_SECRET_KEY
    ```

  4. Alternatively, you can also set the secret key as an environment variable:

    ```elixir
    STRIPE_SECRET_KEY=YOUR_SECRET_KEY
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
