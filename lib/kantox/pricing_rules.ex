defmodule Kantox.PricingRules do
  @moduledoc """
  The PricingRules context.
  """
  alias Kantox.PricingRules.{BulkDiscount, BuyOneGetOneFree, QuantityDiscount}

  def calculate_total(pricing_rules, cart_items) do
    Enum.reduce(pricing_rules, Decimal.new("0"), fn rule, acc ->
      rule.__struct__.apply_discount(rule, cart_items)
      |> Decimal.add(acc)
    end)
  end

  def load_rules do
    [
      # Green tea: buy-one-get-one-free
      %BuyOneGetOneFree{sku: "GR1"},
      # Strawberries: bulk discount when 3+ units: £4.50 each
      %BulkDiscount{sku: "SR1", min_quantity: 3, discounted_price: Decimal.new("4.50")},
      # Coffee: 2/3 price when buying 3+ units
      %QuantityDiscount{sku: "CF1", min_quantity: 3, discount_ratio: Decimal.new("0.6667")}
    ]
  end
end
