defmodule Kantox.PricingRules.BulkDiscount do
  @moduledoc """
  Bulk-discount rule.
  When a customer buys at least min_quantity of products, the price changes to discounted_price.
  """

  defstruct [:sku, :min_quantity, :discounted_price]

  @behaviour Kantox.PricingRules.PricingRule

  @impl true
  def apply_discount(rule, cart_items) do
    applicable_items = Enum.filter(cart_items, &(&1.sku == rule.sku))

    count = length(applicable_items)

    if count >= rule.min_quantity do
      original_price = Decimal.mult(hd(applicable_items).price, Decimal.new(count))
      discounted_price = Decimal.mult(rule.discounted_price, Decimal.new(count))

      Decimal.sub(original_price, discounted_price)
      |> Decimal.round(2)
    else
      Decimal.new("0")
    end
  end
end
