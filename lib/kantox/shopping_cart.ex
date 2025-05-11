defmodule Kantox.ShoppingCart do
  @moduledoc """
  Manages the shopping cart process, including scanning products
  and calculating the total price wit discounts.
  """

  alias Kantox.{PricingRules, Products}

  @doc """
  Scans a product and adds to the cart.
  """
  def scan(cart, sku) do
    product = Enum.find(Products.available_products(), fn product -> product.sku == sku end)

    if product do
      %{cart | items: [product | cart.items]}
    else
      {:error, "Product not found"}
    end
  end

  @doc """
  Calculates the total price of the cart, applying any applicable discounts.
  """
  def total(cart) do
    subtotal = original_price(cart)

    total_discount = total_discount(cart.items)

    Decimal.sub(subtotal, total_discount)
  end

  @doc """
  Calculates the original price of the cart without any discounts.
  """
  def original_price(cart) do
    Enum.reduce(cart.items, Decimal.new("0"), fn item, acc ->
      Decimal.add(acc, item.price)
    end)
  end

  @doc """
  Clears the cart.
  """
  def clear(cart) do
    %{cart | items: []}
  end

  defp total_discount(rules \\ PricingRules.load_rules(), items) do
    PricingRules.calculate_total(rules, items)
  end
end
