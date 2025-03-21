-module(double).
-export([doubles/0, start/0]).
start() ->
    doubles(),
    find_evens(),
    find_odds(),
    quads(),
    square().

doubles() ->
    Doubles = [X * 2 || X <- [1, 2, 3, 4, 5]],
    io:format("New list: ~p~n", [Doubles]).

find_evens() ->
    Evens = [X || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], X rem 2 == 0],
    io:format("Evens:~p~n", [Evens]).

find_odds() ->
    Odds = [X || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], X rem 2 /= 0],
    io:format("Odds: ~p~n", [Odds]).

quads() ->
    Quad = [X * 4 || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
    io:format("Quad List: ~p~n", [Quad]).

square() ->
    Squares = [X || X <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
    io:format("Square List: ~p~n", [Squares]).
