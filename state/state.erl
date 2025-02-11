-module(state).
-export([start/0, start_counter/0, counter/1]).

start_counter() ->
    spawn(?MODULE, counter, [0]).

start() ->
    MainCount = start_counter(),
    loop(MainCount).

loop(Pid) ->
    io:format("Count 'up' or 'down' ~nOr type 'exit' to quit~n"),
    Input = string:trim(io:get_line("-> ")),

    case Input of
        "exit" ->
            io:format("Goodbye!~n"),
            ok;
        "up" ->
            Pid ! {up, self()},
            receive
                {counter, NewCount} ->
                    io:format("New Count: ~p~n", [NewCount])
            end,
            loop(Pid);
        "down" ->
            Pid ! {down, self()},
            receive
                {counter, NewCount} ->
                    io:format("New Count: ~p~n", [NewCount])
            end,
            loop(Pid);
        _ ->
            io:format("Invalid input. Try again.~n"),
            loop(Pid)
    end.

counter(Count) ->
    receive
        {up, From} ->
            NewCount = Count + 1,
            From ! {counter, NewCount},
            counter(NewCount);
        {down, From} ->
            NewCount = Count - 1,
            From ! {counter, NewCount},
            counter(NewCount)
    end.
