-module(rec).
-export([create_person/0]).

%% First we will define a record named => 'person'
-record(person, {name = "Unknown", age = 0, city = "None"}).

%% Function to create and display a person record
create_person() ->
    P = #person{name = "Alice", age = 30, city = "New York"},
    J = #person{name = "Joe", age = 33, city = "Texas"},
    io:format("Person: ~p~n", [P]),
    io:format("Person: ~p~n", [J]).
