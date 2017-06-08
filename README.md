# Stripe [![Build Status](https://semaphoreci.com/api/v1/sikanhe/stripe-elixir/branches/master/badge.svg)](https://semaphoreci.com/sikanhe/stripe-elixir) #

Stripe API client for Elixir. [Documentation](https://hexdocs.pm/stripe_elixir/api-reference.html)
- Everything except for Relay features are complete and tested.
- Looking for more contributors/maintainers for this project, currently need help with documentation.

## Installation

  1. Add `stripe` to your list of dependencies in `mix.exs`:
  

    def deps do
      [{:stripe, "~> 0.4.2", hex: :stripe_elixir}]
    end

  2. (Pre-Elixir 1.4) Ensure `stripe` is started before your application:

    def application do
      [applications: [:stripe]]
    end

  3. Make sure your stripe secret_key is added to your config file:

 
    config :stripe, :secret_key, YOUR_SECRET_KEY


  4. Alternatively, you can also set the secret key as an environment variable:

    export STRIPE_SECRET_KEY=YOUR_SECRET_KEY


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
Create a customer: 
    
    {:ok, %{"id" => "cus_asdfghjkl"} =
       Stripe.Customer.create(email: "example@gmail.com")
       
Note that either KeywordLists or Maps with either String or Atom keys aracceptable for arguments and options. So all of the following would also work: 
   
    Stripe.Customer.create(%{email: "example@gmail.com"}) 
    Stripe.Customer.create(%{"email" => "example@gmail.com"}) 
    Stripe.Customer.create([{"email", "example@gmail.com"}]) 

Retrieve that customer: 
       
    {:ok, customer} = Stripe.Customer.retrieve("cus_asdfghjkl")
Update the customer: 

    {:ok, %{"metadata" => %{"somedata" => "somevalue"}}} = 
      Stripe.Customer.update("cus_asdfghjkl", metadata: [somedata: "somevalue"])
    
Delete the customer 

    {:ok, %{"deleted" => true}} = Stripe.Customer.delete("cus_asdfghjkl")
    
## Stripe Connect 
   
To perform a Direct Charge on a connected stripe account, simply pass :stripe_account as an option 
  
    Stripe.Charge.create([customer: "cus_asdfghjkl",  "amount: 400], stripe_account: "acct_sOMeAcCountId")