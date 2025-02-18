-module(heroes).
-export([]).

start_adventurer() ->
    spawn(?MODULE, hero_status, [{10, 10, 10}]).

loop(Pid)->
    io:format("Choose an action~n1. Train strength~n2.Train Magic~n3.Train Stamina~n or 'q' to quit"),
    Choice = string:trim(io:get_line()),
    case Choice of
        "q" ->
            io:format("Goodbye!~n");
        "1"->
            Pid ! {strength_training, 10, self()},
            receive 
                {up_strength, NewStrength}->
                    io:format("Strength level increased to: ~p~n",[NewStrength])
            end,
            loop(Pid);
        "2" ->
            Pid ! {magic_training, 10, self()},
            receive
                {up_magic, NewMagic} ->
                    io:format("Magic power increased to: ~p~n",[NewMagic])
            end,
            loop(Pid);
        "3" ->
            Pid ! {stamina_training, 10, self()},
            receive
                {up_stamina, NewStamina}->
                    io:format("New Stamina level: ~p~n",[NewStamina])
            end,
            loop(Pid)
