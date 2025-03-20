-module(hero).
-export([adventure/0]).

adventure() ->
    Hero = [
        {hero, 100, 1},
        {enemy1, 50, 4},
        {enemy2, 50, 7},
        {enemy3, 70, 4},
        {enemy4, 80, 1}
    ],
    io:format("Hero's power: ~p~n", [Hero]),
    HeroLevel = lists:foldl(
        fun({_Name, Level, Amount}, Power) ->
            (Level * Amount) + Power
        end,
        0,
        Hero
    ),
    io:format("Hero's power: ~p~n", [HeroLevel]).
