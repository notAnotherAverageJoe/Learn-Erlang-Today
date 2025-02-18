-module(double).
-export([doubles/0, start/0]).
start() ->
    doubles(),
    find_evens().
doubles() ->
    Double = [X * 2 || X <- [2, 4, 6, 8, 10]],
    io:format("New List: ~p~n", [Double]).

find_evens() ->
    Evens = [X || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], X rem 2 == 0],
    io:format("Evens founds: ~p~n", [Evens]).
