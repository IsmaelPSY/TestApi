defmodule TestApiWeb.DefaulController do
  use TestApiWeb, :controller

  def index(conn, _params) do
    text(conn, "TestApi is live - #{Mix.env()}")
  end
end
