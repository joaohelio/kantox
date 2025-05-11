defmodule KantoxWeb.CheckoutLiveTest do
  use KantoxWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "shopping cart" do
    test "empty cart", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/checkout")

      # Check cart is initially empty
      assert html =~ "Your cart is empty"
    end
  end

  describe "adding products to cart" do
    test "adds single product to cart", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/checkout")

      # Add Green tea to cart
      html =
        view
        |> element("button[phx-value-sku='GR1']", "Add")
        |> render_click()

      # Check product appears in cart
      assert html =~ "Your Cart"
      assert html =~ "Green tea"
      assert html =~ "SKU: GR1"
      assert html =~ "£3.11"

      # Check total is updated
      assert html =~ "Total"
      assert html =~ "£3.11"
    end

    test "adds multiple products to cart", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/checkout")

      # Add products to cart
      view
      |> element("button[phx-value-sku='GR1']", "Add")
      |> render_click()

      view
      |> element("button[phx-value-sku='SR1']", "Add")
      |> render_click()

      html =
        view
        |> element("button[phx-value-sku='CF1']", "Add")
        |> render_click()

      # Check individual prices are displayed
      assert html =~ "Green tea × 1"
      assert html =~ "Strawberries × 1"
      assert html =~ "Coffee × 1"

      # Check total is updated
      assert html =~ "Total"
      assert html =~ "£19.34"
    end
  end

  describe "clearing cart" do
    test "removes all items from cart", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/checkout")

      # Add some products
      view
      |> element("button[phx-value-sku='GR1']", "Add")
      |> render_click()

      view
      |> element("button[phx-value-sku='SR1']", "Add")
      |> render_click()

      # Clear cart
      html =
        view
        |> element("button", "Clear cart")
        |> render_click()

      # Check cart is empty
      assert html =~ "Your cart is empty"
      assert html =~ "Add some products to get started"
    end
  end
end
