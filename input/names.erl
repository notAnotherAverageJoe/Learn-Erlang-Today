-module(names).
-export([get_name/0, get_age/0, start/0]).
-author("Joseph Skokan").

start() ->
    get_name(),
    get_age().

get_name() ->
    io:format("Enter your First Name: ~n"),
    FirstName = string:trim(io:get_line("> ")),
    io:format("Enter your Last Name: ~n"),
    LastName = string:trim(io:get_line("> ")),
    io:format("Users Name: ~s ~s~n", [FirstName, LastName]).

get_age() ->
    io:format("Enter your Age: ~n"),
    Age = string:trim(io:get_line("> ")),
    io:format("Users Age: " ++ Age ++ ".~n").
