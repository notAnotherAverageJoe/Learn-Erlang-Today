-module(ship2).
-export([create_ship/0]).

create_ship() ->
    %                       health, missiles, gas, current money
    ShipPid = spawn(?MODULE, ship, [100, 30, 80, 0]),
    loop(ShipPid).

loop(Pid)->
    io:format("1. Space Trucking~n2. Bounty Hunting~p3. Rearm~n4. Refuel"),
    Choice =string:trim(get_line("-> ")),
    case Choice of
        "1" ->
            Pid ! {haul, 20, 20, self() },
            receive 
                {ok_haul, NewGas, NewCash}
