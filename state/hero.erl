-module(hero).
-export([start_hero/0, hero_status/1, loop/1, start/0]).
-author("Joseph Skokan").


start()->
    MainHero = start_hero(),
    loop(MainHero).


start_hero() ->
    spawn(?MODULE, hero_status, [{100, 50, 50}]).

loop(Pid)->
    io:format("1. fight~n2. travel~n3. Fireball~nOr 'q' to quit~n"),
    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1" ->
            Pid ! {damage,10, self()},
            receive
                {health, NewHealth}->
                    io:format("Health: ~p~n",[NewHealth])
                end,
            loop(Pid);
        "2" ->
            Pid ! {stamina_use, 10, self()},
                receive
                    {stamina, NewStamina}->
                        io:format("Stamina: ~p~n",[NewStamina])
                end,
            loop(Pid);
        "q"->
            io:format("Goodbye!~n");
        _ -> 
            io:format("Invalid try again~n"),
        loop(Pid)
    end.




hero_status({Health, Stamina, Mana}) ->
    receive
        {damage, Amount, From} ->
            NewHealth = max(Health - Amount, 0),
            From ! {health, NewHealth},
            hero_status({NewHealth, Stamina, Mana});
        {stamina_use, Amount, From} ->
            NewStamina = max(Stamina - Amount, 0),
            From ! {stamina, NewStamina},
            hero_status({Health, NewStamina, Mana});
        {mana_use, Amount, From} ->
            NewMana = max(Mana - Amount, 0),
            From ! {mana, NewMana},
            hero_status({Health, Stamina, NewMana})
    end.

