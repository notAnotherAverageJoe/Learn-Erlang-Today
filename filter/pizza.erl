-module(pizza).
-export([pizza/0]).

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
    FilterOrdersForPizza(Orders).
