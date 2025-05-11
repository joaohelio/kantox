defmodule KantoxWeb.HealthCheckController do
  use KantoxWeb, :controller

  @doc """
  Health check endpoint.
  """
  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{status: :ok})
  end
end
