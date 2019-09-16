-module(logforwardvslager).
-author('alking').

%% API
-export([
  start/0,
  bench/2
]).

bench(Trials, Threads) ->
  LagerF = fun() -> lager:log(info, [], "abcde ~p", [123]) end,
  LogfF = fun() -> logforward:info("abcde ~p", [123]) end,
  {LagerT, _} = timer:tc(fun() -> bench(LagerF, Trials, Threads) end),
  {LogforwardT, _} = timer:tc(fun() -> bench(LogfF, Trials, Threads) end),
  N = Trials * Threads,
  logforward:info("lager ~p times cost ~p ms ", [N, LagerT / 1000]),
  logforward:info("logforward ~p times cost ~p ms ", [N, LogforwardT / 1000]).


%% @doc bench with multi thread
bench(Fun, Trials, Threads) ->
  PID = self(),
  do_map(Threads, PID, Fun, Trials),
  do_reduce(Threads).

repeat(0, _Fun) -> ok;
repeat(N, Fun) -> Fun(), repeat(N - 1, Fun).


do_map(0, _PID, _F, _Trials) -> ok;
do_map(N, PID, F, Trials) ->
  erlang:spawn(fun() -> repeat(Trials, F), PID ! ok end),
  do_map(N - 1, PID, F, Trials).

do_reduce(0) -> ok;
do_reduce(N) ->
  receive
    _ -> do_reduce(N - 1)
  end.

start() ->
  lager:start(),
  logforward:start().






