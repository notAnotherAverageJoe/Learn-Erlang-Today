-module(pizza2).
-export([start_wallet/0, wallet/1, loop/1, start/0]).

start() ->
    WalletPid = start_wallet(),
    loop(WalletPid).

% start with the process spawn
start_wallet() ->
    spawn(?MODULE, wallet, [125]).

loop(Pid) ->
    io:format("1. Cheese Pizza~n2. Sausage Pizza~n3. Pepperoni Pizza~n"),
    Choice = string:trim(io:get_line("> ")),
    case Choice of
        "1" ->
            Pid ! {cheese, 12, self()},
            receive
                {cheese_pizza, NewWalletAmount} ->
                    io:format("Wallet: ~p~n", [NewWalletAmount])
            end,
            loop(Pid);
        "2" ->
            Pid ! {sausage, 14, self()},
            receive
                {sausage_pizza, NewWalletAmount} ->
                    io:format("Wallet: ~p~n", [NewWalletAmount])
            end,
            loop(Pid);
        "3" ->
            Pid ! {pepperoni, 15, self()},
            receive
                {pepperoni_pizza, NewWalletAmount} ->
                    io:format("Wallet: ~p~n", [NewWalletAmount])
            end,
            loop(Pid);
        _ ->
            io:format("Invalid input, try again!"),
            loop(Pid)
    end.

wallet(WalletPid) ->
    receive
        {cheese, Amount, From} ->
            NewWalletAmount = max(WalletPid - Amount, 0),
            From ! {cheese_pizza, NewWalletAmount},
            wallet(NewWalletAmount);
        {sausage, Amount, From} ->
            NewWalletAmount = max(WalletPid - Amount, 0),
            From ! {sausage_pizza, NewWalletAmount},
            wallet(NewWalletAmount);
        {pepperoni, Amount, From} ->
            NewWalletAmount = max(WalletPid - Amount, 0),
            From ! {pepperoni_pizza, NewWalletAmount},
            wallet(NewWalletAmount)
    end.
