-module(ammo3).
-export([start/0, start_count/0, loop/1, ammo_tracker/1]).
-author("Joseph Skokan").


start()->
    AmmoPid = start_count(),
    loop(AmmoPid).


start_count()->
    spawn(?MODULE, ammo_tracker, [20]).


loop(Pid) ->
    io:format("1. Fire Missiles or 'q' to quit~n"),
    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1" ->
            Pid ! {fire, self()},
            receive
                {ammo, NewAmmoSize}->
                    io:format("Missiles: ~p~n",[NewAmmoSize])
            end,
            loop(Pid);
        "q" ->
            io:format("goodbye!~n");
        _ ->
            io:format("Invalid input!~n"),
        loop(Pid)
    end.

ammo_tracker(Ammo)->
    receive
        {fire, From}->
            NewAmmo = max(Ammo -2 ,0),
            From ! {ammo, NewAmmo},
            ammo_tracker(NewAmmo)
    end.