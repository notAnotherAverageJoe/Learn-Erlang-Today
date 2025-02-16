-module(rec2).
-export([hero_creation/0]).

-record(hero, {name = "Unknown", age = 0, class = "Unknown"}).

hero_creation() ->
    H = #hero{name = "Rhogan", age = 55, class = "Warrior"},
    io:format("Hero Status: ~nName:~p~nAge: ~p~nClass: ~p~n", [
        H#hero.name, H#hero.age, H#hero.class
    ]).
