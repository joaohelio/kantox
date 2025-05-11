defmodule Kantox.Products do
  @moduledoc """
  A module that defines a product.
  """

  alias Kantox.Products.Product

  @doc """
  Mock available products.
  """
  def available_products do
    [
      %Product{sku: "GR1", name: "Green tea", price: Decimal.new("3.11")},
      %Product{sku: "SR1", name: "Strawberries", price: Decimal.new("5.00")},
      %Product{sku: "CF1", name: "Coffee", price: Decimal.new("11.23")}
    ]
  end
end
