defmodule PoolRunner do

  def run(worker_count, functions) do
    pool = start_pool(worker_count)
    Enum.each(functions, fn(fun) ->
      spawn(fn -> pooled_function(pool, fun) end)
    end)
  end


  defp start_pool(worker_count) do
    {:ok, pool} = :poolboy.start(worker_module: PoolRunner.Worker, size: worker_count, max_overflow: 0)
    pool
  end

  defp pooled_function(pool, fun) do
    :poolboy.transaction(pool, fn(worker)->
      GenServer.call(worker, { :run, fun })
    end)
  end

  defmodule Worker do
    def start_link(opts) do
      GenServer.start_link(__MODULE__, :ok, opts)
    end

    def init(state) do
      {:ok, state}
    end

    def handle_call({ :run, fun }, _from, state) do
      {:reply, fun.(), state}
    end
  end

end
