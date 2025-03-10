-module(first).
-export([start/0, numbers_joined/0]).
start() ->
    DefaultMap = #{age => 42, name => "Joe"},
    OtherMap = #{language => erlang},
    Defaults = maps:merge(DefaultMap, OtherMap),
    io:format("~p~n", [Defaults]).

numbers_joined() ->
    FirstHalf = #{nums => [1, 5, 6, 7]},
    SecondHalf = #{nums2 => [2, 3, 4]},
    CombinedLists = lists:sort(maps:values(FirstHalf) ++ maps:values(SecondHalf)),
    io:format("~p~n", [CombinedLists]),
    Merged = lists:flatten(CombinedLists),
    MergedSort = lists:sort(Merged),
    io:format("~p~n", [MergedSort]).
