PoolRunner
==========

Run a list of functions concurrently allowing one to specify the maximum number that can be
running at one time.


## Motivation

I've had  cases where I had a list of a few hundred independent long running operations
that needed to happen.  In each of the cases, the operations couldn't all happen at once since they
depended on a finite set of resources.  Having 8 or so of them happen at once though can be a
significant performance boost.


## Philosophy

I'm not sure this is the best way to go about this.  It's using
[poolboy](https://github.com/devinus/poolboy) under the covers to manage the pool of processes.


## Installation / Dependency

``` elixir
{ :pool_runner, git: "https://github.com/duff/pool_runner"}
```


## Usage


There's only one function (`PoolRunner.run/2`).  You specify the maximum number of functions
that should be running at a time.  And you specify the list of functions to be run.  It will
immediately launch `worker_count` workers.  When a function completes, another one will immediately
run.

``` elixir
def eggcellent(val \\ 1) do
  IO.puts "In - #{val}"
  :timer.sleep(300 * val)
  IO.puts "Finishing - #{val}"
end

functions = [
  fn -> eggcellent end,
  fn -> eggcellent(8) end,
  fn -> eggcellent(3) end,
  fn -> eggcellent end,
  fn -> eggcellent end,
]

PoolRunner.run(3, functions)
```

