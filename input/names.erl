-module(names).
-export([get_name/0]).
-author("Joseph Skokan").

get_name() ->
    io:format("Enter your First Name: ~n"),
    FirstName = string:trim(io:get_line("> ")),
    io:format("Enter your Last Name: ~n"),
    LastName = string:trim(io:get_line("> ")),
    io:format("Users Name: ~s ~s~n", [FirstName, LastName]).
