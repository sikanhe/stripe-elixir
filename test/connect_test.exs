defmodule Stripe.ConnectTest do 
  use ExUnit.Case 

  test "Stripe.Connect.authorize_url/1 should generate urls with correct query params" do 
    url = Stripe.Connect.authorize_url(
      client_id: "TEST_CLIENT_ID",
      state: "TEST_CSRF_TOKEN",
      redirect_uri: "TEST_REDIRECT_URL"
    )

    assert url =~ "client_id=TEST_CLIENT_ID"
    assert url =~ "state=TEST_CSRF_TOKEN"
    assert url =~ "redirect_uri=TEST_REDIRECT_URL"
    assert url =~ "scope=read_write"
    assert url =~ "response_type=code"
  end

  test "Stripe.Connect.authorize_url/1 should raise AuthenticationError when client_id is not set" do
    assert_raise Stripe.AuthenticationError, fn -> Stripe.Connect.authorize_url() end
  end 

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