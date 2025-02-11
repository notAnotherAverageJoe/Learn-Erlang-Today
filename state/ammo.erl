-module(ammo).
-author("Joseph Skokan").
-export([start/0, start_count/0, ammo_tracker/1, loop/1]).

start() ->
    AmmoPid = start_count(),
    loop(AmmoPid).

start_count() ->
    spawn(?MODULE, ammo_tracker, [10]).  % Start with 10 ammo

loop(Pid) ->
    io:format("Choose an option!~n1: Fire one rocket, or 'quit'~n"),
    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1" ->
            Pid ! {single, self()},
            receive
                {ammo, NewAmmoSize} ->
                    io:format("Current Ammo: ~p~n", [NewAmmoSize])
            end,
            loop(Pid);
        "quit" ->
            io:format("Goodbye!~n"),
            ok;
        _ ->
            io:format("Invalid choice, try again.~n"),
            loop(Pid)
    end.

ammo_tracker(Ammo) ->
    receive
        {single, From} ->
            NewAmmo = max(Ammo - 1, 0),
            From ! {ammo, NewAmmo},
            ammo_tracker(NewAmmo)
    end.
