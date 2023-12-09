defmodule TestApiWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule TestApiWeb.Auth.ErrorResponse.IncompleteData do
  defexception message: "Need to complete data", plug_status: 422
end
