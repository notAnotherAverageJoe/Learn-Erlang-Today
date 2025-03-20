-module(mlearn).
-export([start/0]).
start() ->
    Person = #{name => "Steve", age => 67},
    FavoriteLang = #{plang => "Erlang"},
    Combined = maps:merge(Person, FavoriteLang),
    io:format("Person: ~p~n", [Combined]),
    numbers_joined().

numbers_joined() ->
    FirstHalf = #{nums => [1, 5, 7, 3]},
    SecondHalf = #{nums2 => [2, 8, 6, 4]},
    CombinedLists = lists:sort(maps:values(FirstHalf) ++ maps:values(SecondHalf)),
    io:format("~p~n", [CombinedLists]),
    Merged = lists:flatten(CombinedLists),
    MergedSort = lists:sort(Merged),
    io:format("Merged and sorted : ~p~n", [MergedSort]).
