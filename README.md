logforwardvslager
=====

```
rebar get-deps

rebar compile

windows:

werl -pa deps\goldrush\ebin -pa deps\lager\ebin -pa deps\logforward\ebin  -pa ebin  -s logforwardvslager

linux:

erl -pa deps/goldrush/ebin -pa deps/lager/ebin -pa deps/logforward/ebin  -pa ebin  -s logforwardvslager

```

bench result
```
% 1000 threads and 1000 per thread
2019-09-26 18:00:06.446 [INFO] - lager 1000000 times cost 1747.0 ms 
2019-09-26 18:00:06.446 [INFO] - logforward 1000000 times cost 936.0 ms 

% 100 threads and 1000 per thread
logforwardvslager:bench(1000,100).
2019-09-16 13:19:15.090 [INFO] - lager 100000 times cost 125.0 ms 
2019-09-16 13:19:15.090 [INFO] - logforward 100000 times cost 62.0 ms 

% 1000 threads and 100 per thread
logforwardvslager:bench(100,1000).
2019-09-16 13:31:24.980 [INFO] - lager 100000 times cost 125.0 ms 
2019-09-16 13:31:24.980 [INFO] - logforward 100000 times cost 109.0 ms 

% 100 threads and 100 per thread
logforwardvslager:bench(100,100).
2019-09-16 13:25:55.052 [INFO] - lager 10000 times cost 16.0 ms 
2019-09-16 13:25:55.052 [INFO] - logforward 10000 times cost 15.0 ms 
```

```


```