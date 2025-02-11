-module(drinks).
-export([orders/0, wallet/1]).

orders() ->
    io:format("What drink would you like to order? "),
    Drink = string:trim(io:get_line("> ")),
    case list_to_atom(Drink) of
        coffee ->
            io:format("Brewing a hot cup of coffee!~n");
        tea ->
            io:format("Steeping some tea!~n");
        water ->
            io:format("A cold glass of water it is!~n"),
            % Pass 'water' to wallet/1
            wallet(water);
        _ ->
            io:format("Sorry, we can't brew that.~n")
    end.

wallet(water) ->
    Money = 100,
    io:format("Cash: ~w~n", [Money]),
    NewMoney = Money - 5,
    io:format("Cash after purchase: ~w~n", [NewMoney]);
wallet(_) ->
    io:format("No purchase made.~n").
