-module(rec2).
-export([hero_creation/0]).

-record(hero, {name = "Unknown", age = 0, class = "Unknown"}).

hero_creation() ->
    H = #hero{name = "Rhorg", age = 43, class = "Warrior"},
    io:format("Hero Status: ~nName: ~s~nAge: ~p~nClass: ~s~n", [
        H#hero.name, H#hero.age, H#hero.class
    ]).
