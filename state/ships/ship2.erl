-module(ship2).
-export([create_ship/0, loop/1, ship/4]).

create_ship() ->
    %                       health, missiles, gas, current money
    ShipPid = spawn(?MODULE, ship, [100, 30, 80, 0]),
    loop(ShipPid).

loop(Pid) ->
    io:format("1. Space Trucking~n2. Bounty Hunting~n3. Rearm~n"),
    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1" ->
            Pid ! {haul, 20, 20, self()},
            receive
                {ok_haul, NewGas, NewCash} ->
                    io:format("Current Gas: ~p~nCurrent Cash: ~p~n", [NewGas, NewCash])
            end,
            loop(Pid);
        "2" ->
            Pid ! {hunt, 20, 15, 10, 40, self()},
            receive
                {ok_hunt, NewHealth, NewAmmo, NewGas, NewCash} ->
                    io:format(
                        "Current Health: ~p~nCurrent Ammo: ~p~nCurrent Gas: ~p~nCurrent Cash: ~p~n",
                        [NewHealth, NewAmmo, NewGas, NewCash]
                    )
            end,
            loop(Pid);
        "3" ->
            Pid ! {arms, 15, 20, self()},
            receive
                {ok_armed, NewAmmo, NewCash} ->
                    io:format("Current Ammo: ~p~n,Current Cash: ~p~n", [NewAmmo, NewCash])
            end,
            loop(Pid);
        _ ->
            io:format("Invalid, goodbye!")
    end.

ship(Health, Missiles, Gas, Money) ->
    receive
        {haul, GasCost, MoneyMade, From} ->
            NewGas = max(0, Gas - GasCost),
            NewCash = Money + MoneyMade,
            From ! {ok_haul, NewGas, NewCash},
            ship(Health, Missiles, NewGas, NewCash);
        {hunt, Damage, AmmoUsed, GasCost, MoneyMade, From} ->
            NewHealth = max(0, Health - Damage),
            NewAmmo = max(0, Missiles - AmmoUsed),
            NewGas = max(0, Gas - GasCost),
            NewCash = (Money + MoneyMade),
            From ! {ok_hunt, NewHealth, NewAmmo, NewGas, NewCash},
            ship(NewHealth, NewAmmo, NewGas, NewCash);
        {arms, AmmoAdded, MoneyLost, From} ->
            NewAmmo = Missiles + AmmoAdded,
            NewCash = max(0, Money - MoneyLost),
            From ! {ok_armed, NewAmmo, NewCash},
            ship(Health, NewAmmo, Gas, NewCash);
        _ ->
            io:format("Invalid ")
    end.
