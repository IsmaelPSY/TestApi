defmodule TestApiWeb.ValidateController do
  use TestApiWeb, :controller

  def validate(%Plug.Conn{} = conn, %{multiple: multiple}) do
    account = conn.private[:guardian_default_resource]
    TestApi.DefaultWorker
    send_resp(conn, :no_content, "")
  end
end
