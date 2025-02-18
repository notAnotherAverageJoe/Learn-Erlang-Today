-module(heroes).
-export([start/0, hero_status/1]).

start() ->
    HeroPid = start_adventurer(),
    loop(HeroPid).

start_adventurer() ->
    spawn(?MODULE, hero_status, [{10, 10, 10}]).

loop(Pid) ->
    io:format(
        "Choose an action~n1.Train strength~n2.Train Magic~n3.Train Stamina~n or 'q' to quit"
    ),
    Choice = string:trim(io:get_line("> ")),
    case Choice of
        "q" ->
            io:format("Goodbye!~n");
        "1" ->
            Pid ! {strength_training, 10, self()},
            receive
                {up_strength, NewStrength} ->
                    io:format("Strength level increased to: ~p~n", [NewStrength])
            end,
            loop(Pid);
        "2" ->
            Pid ! {magic_training, 10, self()},
            receive
                {up_magic, NewMagic} ->
                    io:format("Magic power increased to: ~p~n", [NewMagic])
            end,
            loop(Pid);
        "3" ->
            Pid ! {stamina_training, 10, self()},
            receive
                {up_stamina, NewStamina} ->
                    io:format("New Stamina level: ~p~n", [NewStamina])
            end,
            loop(Pid);
        _ ->
            io:format("Invalid option try again~n"),
            loop(Pid)
    end.

hero_status({Strength, Magic, Stamina}) ->
    receive
        {strength_training, Amount, From} ->
            NewStrength = (Amount + Strength),
            From ! {up_strength, NewStrength},
            hero_status({NewStrength, Magic, Stamina});
        {magic_training, Amount, From} ->
            NewMagic = (Amount + Magic),
            From ! {up_magic, NewMagic},
            hero_status({Strength, NewMagic, Stamina});
        {stamina_training, Amount, From} ->
            NewStamina = (Amount + Stamina),
            From ! {up_stamina, NewStamina},
            hero_status({Strength, Magic, NewStamina})
    end.
