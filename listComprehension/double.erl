-module(double).
-export([doubles/0]).

doubles() ->
    Double = [X || X <- [2, 4, 6, 8, 10], X * 2],
    io:format("New List: ~p~n", [Double]).
