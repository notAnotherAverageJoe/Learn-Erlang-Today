-module(pizza).
-export([start_wallet/0, wallet/1, loop/1, start/0]).
-author("Joseph Skokan").

start() ->
    WalletPid = start_wallet(),
    loop(WalletPid).
start_wallet() ->
    spawn(?MODULE, wallet, [100]).

loop(Pid) ->
    io:format("1. Cheese Pizza~n2. Pepperoni Pizza~n"),
    Choice = string:trim(io:get_line("> ")),
    case Choice of
        "1" ->
            Pid ! {cheese, 12, self()},
            receive
                {cheese_pizza, NewWallet} ->
                    io:format("Wallet: ~p~n", [NewWallet])
            end,
            loop(Pid);
        "2" ->
            Pid ! {pepperoni, 14, self()},
            receive
                {pep_pizza, NewWallet} ->
                    io:format("Wallet ~p~n", [NewWallet])
            end,
            loop(Pid)
    end.

wallet(WalletPid) ->
    receive
        {cheese, Amount, From} ->
            NewWallet = max(WalletPid - Amount, 0),
            From ! {cheese_pizza, NewWallet},
            wallet(NewWallet);
        {pepperoni, Amount, From} ->
            NewWallet = max(WalletPid - Amount, 0),
            From ! {pep_pizza, NewWallet},
            wallet(NewWallet)
    end.
