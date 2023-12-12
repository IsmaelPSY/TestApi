defmodule TestApi.Workers.Transaction do
  alias TestApi.Transactions
  use Oban.Worker, queue: :default, max_attempts: 5

  alias TestApi.Workers

  @impl Oban.Worker
  def perform(%Oban.Job{attempt: attempt, args: %{"transaction_id" => transaction_id}})
      when attempt == 5 do
    case compare_random_numbers() do
      false ->
        update_transaction(transaction_id, "failed")

        %{"transaction_id" => transaction_id}
        |> Workers.Failed.new()
        |> Oban.insert()

        {:error, "Transaction failed."}

      true ->
        update_transaction(transaction_id, "completed")

        %{"transaction_id" => transaction_id}
        |> Workers.Completed.new()
        |> Oban.insert()

        :ok
    end
  end

  def perform(%Oban.Job{args: %{"transaction_id" => transaction_id}}) do
    # to simulate a fetch to an external server
    # for the status of the transaction
    # we will compare two random numbers, if they
    # are equal the transaction status would be "completed"
    # otherwise "failed"
    case compare_random_numbers() do
      false ->
        {:error, "Transaction still not completed. Waiting."}

      true ->
        update_transaction(transaction_id, "completed")

        %{"transaction_id" => transaction_id}
        |> Workers.Completed.new()
        |> Oban.insert()

        :ok
    end
  end

  def backoff(%Job{attempt: _attempt}) do
    15
  end

  defp compare_random_numbers do
    :rand.uniform(4) == :rand.uniform(4)
  end

  defp update_transaction(id, status) do
    Transactions.get_transaction!(id)
    |> Transactions.update_transaction(%{status: status})
  end
end
