-module(ship).
-export([]).

create_ship() ->
    % health, missiles, gas, money
    spawn(?MODULE, [{100, 20, 85, 0}]).

loop(Pid)->
    io:format("Welcome commander!"),
    io:format("What would you like to do?~n1.Space Haul Mission~n2.Bounty Hunter Work~n3.Rearm/Refuel~n"),
    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1"->
            Pid ! {haul, }
