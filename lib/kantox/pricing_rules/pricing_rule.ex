defmodule Kantox.PricingRules.PricingRule do
  @moduledoc """
  A module that defines a pricing rule interface.
  """

  @callback apply_discount(rule :: struct(), cart_items :: list()) :: Decimal.t()
end
