defmodule Kantox.PricingRules.BuyOneGetOneFree do
  @moduledoc """
  Buy-one-get-one-free rule.
  When a customer buys an even number of products, the price changes to half the original price.
  """

  defstruct [:sku]

  @behaviour Kantox.PricingRules.PricingRule

  @impl true
  def apply_discount(rule, cart_items) do
    applicable_items = Enum.filter(cart_items, &(&1.sku == rule.sku))

    if length(applicable_items) > 1 do
      free_items_count = div(length(applicable_items), 2)
      item_price = hd(applicable_items).price

      Decimal.mult(free_items_count, item_price)
      |> Decimal.round(2)
    else
      Decimal.new("0")
    end
  end
end
