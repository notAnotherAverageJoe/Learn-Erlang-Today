-module(first).
-export([start/0]).
start() ->
    DefaultMap = #{age => 42, name => "Joe"},
    OtherMap = #{language => erlang},
    Defaults = maps:merge(DefaultMap, OtherMap),
    io:format("~p~n", [Defaults]).
