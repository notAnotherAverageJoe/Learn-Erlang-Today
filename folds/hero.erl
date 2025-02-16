-module(hero).
-export([adventure/0]).

adventure() ->
    Hero = [
        {hero, 100, 1},
        {enemy1, 50, 1},
        {enemy2, 50, 1},
        {enemy3, 70, 1},
        {enemy4, 80, 1}
    ],

    HeroLevel = lists:foldl(
        fun({_Name, Level, Amount}, Power) ->
            (Level * Amount) + Power
        end,
        0,
        Hero
    ),
    io:format("Hero's Power -> ~p~n", [HeroLevel]).
