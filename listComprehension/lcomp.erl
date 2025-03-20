-module(lcomp).
-export([double/0, start/0]).

start() ->
    double(),
    triple(),
    find_evens(),
    find_odds().
double() ->
    Doubles = [X * 2 || X <- [1, 2, 3, 4, 5]],
    io:format("New List: ~p~n", [Doubles]).
triple() ->
    Triples = [X * 3 || X <- [1, 2, 3, 4, 5]],
    io:format("Triple List: ~p~n", [Triples]).
find_evens() ->
    Evens = [X || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], X rem 2 == 0],
    io:format("Evens: ~p~n", [Evens]).
find_odds() ->
    Odds = [X || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], X rem 2 /= 0],
    io:format("Odds: ~p~n", [Odds]).
