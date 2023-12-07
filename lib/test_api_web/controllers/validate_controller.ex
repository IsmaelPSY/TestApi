defmodule TestApiWeb.ValidateController do
  use TestApiWeb, :controller

  def validate(conn, %{multiple: multiple}) do
    send_resp(conn, :no_content, "")
  end
end
