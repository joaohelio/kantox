defmodule KantoxWeb.CheckoutLive do
  use KantoxWeb, :live_view

  alias Kantox.{Products, ShoppingCart}

  def mount(_params, _session, socket) do
    cart = %ShoppingCart.Cart{items: []}

    socket =
      socket
      |> assign(:products, Products.available_products())
      |> assign(:cart, cart)
      |> assign(:subtotal, ShoppingCart.original_price(cart))
      |> assign(:total, ShoppingCart.total(cart))

    {:ok, socket}
  end

  def handle_event("add-product", %{"sku" => sku}, socket) do
    cart = socket.assigns.cart

    updated_cart = ShoppingCart.scan(cart, sku)

    {:noreply, assign_params(socket, updated_cart)}
  end

  def handle_event("clear-cart", _, socket) do
    cart = socket.assigns.cart

    updated_cart = ShoppingCart.clear(cart)

    {:noreply, assign_params(socket, updated_cart)}
  end

  def format_price(price) do
    "£#{Decimal.to_string(price)}"
  end

  defp assign_params(socket, cart) do
    socket
    |> assign(:cart, cart)
    |> assign(:subtotal, ShoppingCart.original_price(cart))
    |> assign(:total, ShoppingCart.total(cart))
  end
end
