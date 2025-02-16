-module(cereal).
-export([breakfast/0]).
-author("Joe").

breakfast() ->
    Cereals = [
        {trix, 5.99, 2},
        {raisin, 5.99, 2},
        {pebbles, 5.99, 2},
        {cocopuffs, 5.99, 2},
        {luckycharms, 5.99, 2},
        {frostedwheaties, 5.99, 2}
    ],

    lists:foldl(
        fun({_Cereal, Price, Quantity}, Sum) ->
            (Price * Quantity) + Sum
        end,
        0,
        Cereals
    ).
