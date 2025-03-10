-module(first).
-export([start/0]).
start() ->
    DefaultMap = #{age => 42, name => "Joe"},
    OtherMap = #{language => erlang},
    Defaults = maps:merge(DefaultMap, OtherMap),
    io:format("~p~n", [Defaults]).

numbers_joined() ->
    FirstHalf = #{nums => [1, 5, 6, 7]},
    SecondHalf = #{nums2 => [2, 3, 4]},
    Default = maps:merge(FirstHalf, SecondHalf),
    io:format("~p~n").
