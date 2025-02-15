-module(pizza).
-export([pizza/0, number_of_orders/2]).

pizza() ->
    Orders = [
        {turkey, "James"},
        {pizza, "Jill"},
        {chicken, "bill"},
        {pizza, "John"},
        {coffee, "Joseph"}
    ],

    FilterOrdersForPizza = fun(Order) ->
        lists:filter(
            fun({Item, _Customer}) ->
                Item == pizza
            end,
            Order
        )
    end,

    FilterOrdersForChicken = fun(Order) ->
        lists:filter(
            fun({Item, _Customer}) ->
                Item == chicken
            end,
            Order
        )
    end,
    FilterOrdersForChicken = fun(Order, CustomItem) ->
        lists:filter(
            fun({Item, _Customer}) ->
                Item == CustomItem
            end,
            Order
        )
    end,
    io:format("Total Orders: ~p~n", [number_of_orders(Orders, 0)]),

    io:format("Pizza Orders: ~p~n", [FilterOrdersForPizza(Orders)]),
    io:format("Chicken Orders: ~p~n", [FilterOrdersForChicken(Orders)]).

number_of_orders([], Acc) -> Acc;
number_of_orders([_Hd | Tl], Acc) -> number_of_orders(Tl, Acc + 1).
