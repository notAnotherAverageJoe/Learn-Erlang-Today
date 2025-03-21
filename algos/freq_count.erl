-module(freq_count).
-export([count/1]).

count(List) ->
    count(List, #{}).

count([], Acc) ->
    Acc;
count([H | T], Acc) ->
    count(T, maps:update_with(H, fun(V) -> V + 1 end, 1, Acc)).
