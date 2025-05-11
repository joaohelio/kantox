defmodule Kantox.PricingRules.QuantityDiscount do
  @moduledoc """
  Quantity-discount rule.
  When a customer buys at least min_quantity of products, the price for all is reduced
  by multiplying by the discount_ratio.
  """

  defstruct [:sku, :min_quantity, :discount_ratio]

  @behaviour Kantox.PricingRules.PricingRule

  @impl true
  def apply_discount(rule, cart_items) do
    applicable_items = Enum.filter(cart_items, &(&1.sku == rule.sku))

    count = length(applicable_items)

    if count >= rule.min_quantity do
      original_price = Decimal.mult(hd(applicable_items).price, Decimal.new(count))
      discount = Decimal.mult(original_price, Decimal.sub(Decimal.new(1), rule.discount_ratio))

      Decimal.round(discount, 2)
    else
      Decimal.new("0")
    end
  end
end
