-module(cereal).
-export([breakfast/0]).
-author("Joe").

breakfast() ->
    Cereals = [
        {trix, 5.99, 2},
        {raisin, 4.73, 2},
        {pebbles, 7.99, 2},
        {cocopuffs, 6.99, 4},
        {luckycharms, 5.35, 5},
        {frostedwheaties, 8.78, 22}
    ],
    Total = lists:foldl(
        fun({_Cereal, Price, Quantity}, Sum) ->
            (Price * Quantity) + Sum
        end,
        0,
        Cereals
    ),
    io:format("Total Cost: $~.2f~n", [Total]).
