defmodule TestApi.Workers.Completed do
  alias TestApi.Transactions
  use Oban.Worker, queue: :default, max_attempts: 5

  @impl Oban.Worker
  # def perform(%Oban.Job{attempt: attempt, args: %{"transaction_id" => transaction_id}})
  #     when attempt == 5 do
  #   case compare_random_numbers() do
  #     false ->
  #       update_transaction(transaction_id, "failed")

  #       {:error, "Transaction failed."}

  #     true ->
  #       update_transaction(transaction_id, "completed")
  #       :ok
  #   end
  # end

  def perform(%Oban.Job{args: %{"transaction_id" => transaction_id}}) do
    # to simulate a fetch to an external server
    # for the status of the transaction
    # we will compare two random numbers, if they
    # are equal the transaction status would be "completed"
    # otherwise "failed"

    IO.puts("Failed completed with  id #{transaction_id}")

    # case compare_random_numbers() do
    #   false ->
    #     {:error, "Transaction still not completed. Waiting."}

    #   true ->
    #     update_transaction(transaction_id, "completed")
    #     :ok
    # end
  end

  def backoff(%Job{attempt: _attempt}) do
    15
  end

  # defp compare_random_numbers do
  #   :rand.uniform(4) == :rand.uniform(4)
  # end

  # defp update_transaction(id, status) do
  #   Transactions.get_transaction!(id)
  #   |> Transactions.update_transaction(%{status: status})
  # end
end
