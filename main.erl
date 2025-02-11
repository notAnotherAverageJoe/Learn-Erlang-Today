-module(main).
-author("Joe").
-export([greetings/0]).

greetings() ->
    io:format("Hello, World!~n").
