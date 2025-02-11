-module(ammo2).
-export([start_count/0, start/0, loop/1, ammo_tracker/1,start_shield/0]).


start()->
    AmmoPid = start_count(),
    loop(AmmoPid).

start_shield()->
    spawn(?MODULE, shield_tracker,[100]).


start_count()->
    %this creates the PID to track ammo
    %the module is simply ammo2
    % this line says ammo2 
    % %ammo_tracker(20) essentially Ammo = 20
    %this process will run in the background managing state
    spawn(?MODULE, ammo_tracker, [20]).

loop(Pid)->
    io:format("1. Fire one missile~n2. Fire two missiles~nor 'q' to quit~n"),
    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1" ->
            Pid !{single, self()},
            receive
                {ammo, NewAmmoSize} ->
                    io:format("Missiles: ~p~n",[NewAmmoSize])
            end,
            loop(Pid);
        "2" ->
            Pid !{two, self()},
            receive 
                {ammo, NewAmmoSize} ->
                    io:format("Missiles: ~p~n",[NewAmmoSize])
            end,
            loop(Pid);
                    
        "q" ->
            io:format("Goodbye!~n");
        _ ->
            io:format("Invalid input"),
            loop(Pid)
    end.



ammo_tracker(Ammo) ->
    receive
        {single, From} ->
            % won't allow ammo to go below 0
            NewAmmo = max(Ammo - 1, 0),
            From ! {ammo, NewAmmo},
            ammo_tracker(NewAmmo);
        {two, From}->
            NewAmmo = max(Ammo - 2, 0),
            From ! {ammo, NewAmmo},
            ammo_tracker(NewAmmo)
    end.