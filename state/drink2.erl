-module(drink2).
-export([orders/1, wallet/1, start_wallet/0, start/0]).

start() ->
    WalletPid = drink2:start_wallet(),
    drink2:orders(WalletPid).

start_wallet() ->
    spawn(drink2, wallet, [100]).

orders(WalletPid) ->
    io:format("What drink would you like to order? (type 'exit' to quit)~n"),
    Drink = string:trim(io:get_line("> ")),
    case list_to_atom(Drink) of
        exit ->
            io:format("Goodbye!~n");
        coffee ->
            io:format("Brewing a hot cup of coffee!~n"),
            WalletPid ! {buy, 10, self()},
            receive
                {balance, NewBalance} -> io:format("New balance: ~w~n", [NewBalance])
            end,
            orders(WalletPid);
        tea ->
            io:format("Steeping some tea!~n"),
            WalletPid ! {buy, 7, self()},
            receive
                {balance, NewBalance} -> io:format("New balance: ~w~n", [NewBalance])
            end,
            orders(WalletPid);
        water ->
            io:format("A cold glass of water it is!~n"),
            WalletPid ! {buy, 5, self()},
            receive
                {balance, NewBalance} -> io:format("New balance: ~w~n", [NewBalance])
            end,
            orders(WalletPid);
        _ ->
            io:format("Sorry, we can't brew that.~n"),
            orders(WalletPid)
    end.

wallet(Balance) ->
    receive
        {buy, Price, From} when Balance >= Price ->
            NewBalance = Balance - Price,
            From ! {balance, NewBalance},
            wallet(NewBalance);
        {buy, Price, From} ->
            io:format("Not enough funds!~n"),
            From ! {balance, Balance},
            wallet(Balance);
        {get_balance, From} ->
            From ! {balance, Balance},
            wallet(Balance)
    end.
