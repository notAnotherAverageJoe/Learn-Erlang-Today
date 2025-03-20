-module(freq).
-export([count_frequencies/1]).

count_frequencies(List) ->
    count_frequencies(List, #{}).

count_frequencies([], Acc) ->
    Acc;
count_frequencies([H | T], Acc) ->
    count_frequencies(T, maps:update_with(H, fun(V) -> V + 1 end, 1, Acc)).
