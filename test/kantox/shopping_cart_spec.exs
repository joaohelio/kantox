defmodule Kantox.ShoppingCartTest do
  use ExUnit.Case, async: true
  alias Kantox.{Products, ShoppingCart}

  setup do
    cart = %ShoppingCart.Cart{
      items: []
    }

    {:ok, cart: cart}
  end

  test "add a product to the cart", %{cart: cart} do
    cart = ShoppingCart.scan(cart, "GR1")

    product_added = cart.items |> List.first()

    price = Decimal.new("3.11")

    assert %Products.Product{
             sku: "GR1",
             name: "Green tea",
             price: ^price
           } = product_added
  end

  test "calculate total price for empty cart", %{cart: cart} do
    assert ShoppingCart.total(cart) == Decimal.new("0")
  end

  test "SR1,SR1,GR1,SR1 should total £16.61", %{cart: cart} do
    cart =
      cart
      |> ShoppingCart.scan("SR1")
      |> ShoppingCart.scan("SR1")
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("SR1")

    assert ShoppingCart.total(cart) == Decimal.new("16.61")
  end

  test "GR1,SR1,GR1,GR1,CF1 should total £22.45", %{cart: cart} do
    cart =
      cart
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("SR1")
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("CF1")

    assert ShoppingCart.total(cart) == Decimal.new("22.45")
  end

  test "GR1,GR1 should total £3.11", %{cart: cart} do
    cart =
      cart
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("GR1")

    assert ShoppingCart.total(cart) == Decimal.new("3.11")
  end

  test "GR1,CF1,SR1,CF1,CF1 should total £30.57", %{cart: cart} do
    cart =
      cart
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("CF1")
      |> ShoppingCart.scan("SR1")
      |> ShoppingCart.scan("CF1")
      |> ShoppingCart.scan("CF1")

    assert ShoppingCart.total(cart) == Decimal.new("30.57")
  end

  test "handles unknown product codes", %{cart: cart} do
    assert {:error, "Product not found"} = ShoppingCart.scan(cart, "XX1")
  end

  test "scan products in different order yields same total", %{cart: cart} do
    cart1 =
      cart
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("SR1")
      |> ShoppingCart.scan("CF1")

    cart2 =
      cart
      |> ShoppingCart.scan("CF1")
      |> ShoppingCart.scan("GR1")
      |> ShoppingCart.scan("SR1")

    assert ShoppingCart.total(cart1) == ShoppingCart.total(cart2)
  end
end
