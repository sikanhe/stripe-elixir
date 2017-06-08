defmodule Stripe.ConnectTest do 
  use ExUnit.Case 

  test "retrive method should be able to recognize stripe_account option" do 
    assert {:error, api_error} = 
      Stripe.Customer.retrieve("abc", stripe_account: "acct_19tNirFUbEJstA5") 

    assert api_error.message =~ "does not have access to account"
  end

  test "create method should be able to recognize stripe_account option" do 
    assert {:error, api_error} = 
      Stripe.Customer.create([], stripe_account: "acct_19tNirFUbEJstA5") 

    assert api_error.message =~ "does not have access to account"
  end

  test "update method should be able to recognize stripe_account option" do 
    assert {:error, api_error} = 
      Stripe.Customer.update("abc", [], stripe_account: "acct_19tNirFUbEJstA5") 

    assert api_error.message =~ "does not have access to account"
  end

  test "delete method should be able to recognize stripe_account option" do 
    assert {:error, api_error} = 
      Stripe.Customer.delete("abc", [], stripe_account: "acct_19tNirFUbEJstA5") 

    assert api_error.message =~ "does not have access to account"
  end
end