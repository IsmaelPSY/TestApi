defmodule TestApi.Workers.Default do
  use Oban.Worker, queue: :default, max_attempts: 5

  @impl Oban.Worker
  def perform(%Oban.Job{args: args}) do
    IO.inspect(args)
    :ok
  end
end
