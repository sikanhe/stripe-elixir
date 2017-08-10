defmodule Stripe.TokenTest do
  use ExUnit.Case, async: true
  import Stripe.TokenHelpers

  alias Stripe.Token
  alias Stripe.{InvalidRequestError, CardError}

  test "create a token" do
    assert {:ok, token} = valid_card() |> Token.create()

    assert {:ok, ^token} = Token.retrieve(token["id"])
  end

  test "card error" do
    assert {:error, %CardError{param: "number", code: "incorrect_number"}} = invalid_card() |> Token.create()
  end

  test "retrieve a token" do
    assert {:error, %InvalidRequestError{message: "No such token: not exist"}}
      = Token.retrieve("not exist")
  end
end
