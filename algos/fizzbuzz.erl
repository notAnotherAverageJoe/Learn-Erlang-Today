-module(fizzbuzz).
-export([fizz/1, fizzbuzz/1]).

fizzbuzz(N) when N > 0 ->
    lists:foreach(fun fizz/1, lists:seq(1, N)).

fizz(N) ->
    case {N rem 3, N rem 5} of
        {0, 0} -> io:format("FizzBuzz~n");
        {0, _} -> io:format("Fizz~n");
        {_, 0} -> io:format("Buzz~n");
        _ -> io:format("~p~n", [N])
    end.
