-module(ship).
-export([create_ship/0, loop/1, ship/4]).

create_ship() ->
    % Initializing the ship process with (Health, Missiles, Gas, Money)
    ShipPid = spawn(?MODULE, ship, [100, 20, 85, 0]),
    loop(ShipPid).

loop(Pid) ->
    io:format("Welcome commander!~n"),
    io:format(
        "What would you like to do?~n1. Space Haul Mission~n2. Bounty Hunter Work~n3. Rearm/Refuel~n"
    ),

    Choice = string:trim(io:get_line("-> ")),
    case Choice of
        "1" ->
            Pid ! {haul, 40, 20, self()},
            receive
                {ok_haul, NewGas, NewWallet} ->
                    io:format("Current Gas: ~p~nCurrent Cash: ~p~n", [NewGas, NewWallet])
            end,
            loop(Pid);
        "2" ->
            Pid ! {hunt, 10, 10, 10, 30, self()},
            receive
                {ok_hunt, NewHealth, NewAmmo, NewGas, NewWallet} ->
                    io:format(
                        "Current Shield: ~p~nCurrent Gas: ~p~nCurrent Missiles: ~p~nCurrent Cash: ~p~n",
                        [NewHealth, NewGas, NewAmmo, NewWallet]
                    )
            end,
            loop(Pid);
        "3" ->
            Pid ! {buy, 10, 10, 10, 10, self()},
            receive
                {ok_buy, NewHealth, NewAmmo, NewGas, NewWallet} ->
                    io:format(
                        "Current Shield: ~p~nCurrent Gas: ~p~nCurrent Missiles: ~p~nCurrent Cash: ~p~n",
                        [NewHealth, NewGas, NewAmmo, NewWallet]
                    )
            end,
            loop(Pid);
        _ ->
            io:format("Invalid input~n"),
            loop(Pid)
    end.

ship(Health, Missiles, Gas, Wallet) ->
    receive
        {haul, GasCost, MoneyGain, From} ->
            NewGas = Gas - GasCost,
            NewWallet = Wallet + MoneyGain,
            From ! {ok_haul, NewGas, NewWallet},
            ship(Health, Missiles, NewGas, NewWallet);
        {hunt, HealthLoss, AmmoCost, GasCost, Reward, From} ->
            NewHealth = max(0, Health - HealthLoss),
            NewAmmo = max(0, Missiles - AmmoCost),
            NewGas = max(0, Gas - GasCost),
            NewWallet = Wallet + Reward,
            From ! {ok_hunt, NewHealth, NewAmmo, NewGas, NewWallet},
            ship(NewHealth, NewAmmo, NewGas, NewWallet);
        {buy, HealthGain, AmmoGain, GasGain, Cost, From} when Wallet >= Cost ->
            NewHealth = Health + HealthGain,
            NewAmmo = Missiles + AmmoGain,
            NewGas = Gas + GasGain,
            NewWallet = Wallet - Cost,
            From ! {ok_buy, NewHealth, NewAmmo, NewGas, NewWallet},
            ship(NewHealth, NewAmmo, NewGas, NewWallet);
        {buy, _, _, _, Cost, From} when Wallet < Cost ->
            From ! {error, "Not enough money!"},
            ship(Health, Missiles, Gas, Wallet);
        _ ->
            ship(Health, Missiles, Gas, Wallet)
    end.
