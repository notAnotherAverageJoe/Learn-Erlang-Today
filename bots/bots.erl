-module(bots).
-export([start/0, loop/0, categorize_query/1]).

start() ->
    io:format("Starting bot...~n"),
    loop().

loop() ->
    io:format("Welcome! How can I help you?~n"),
    Answer = string:trim(io:get_line("-> ")),
    % Debug print to show user input
    io:format("You said: ~s~n", [Answer]),
    case categorize_query(Answer) of
        account_issue ->
            io:format("Help with account issues coming up!~n"),
            spaces(),
            loop();
        password_reset ->
            io:format("Password reset process initiated.~n"),
            spaces(),
            loop();
        username_change ->
            io:format("Changing your username is simple!~n"),
            spaces(),
            loop();
        system_error ->
            io:format("It looks like you're experiencing a system error.~n"),
            spaces(),
            loop();
        human_assistance ->
            io:format("Would you like a human agent to assist you further? (yes/no)~n"),
            spaces(),
            loop();
        exit ->
            io:format("Goodbye!~n"),
            ok;
        unknown ->
            io:format("I didn't understand that, please try again.~n"),
            loop()
    end.

categorize_query(Answer) ->
    LowerCase = string:lowercase(Answer),
    AccountPos = string:find(LowerCase, "account"),
    PasswordPos = string:find(LowerCase, "password"),
    UsernamePos = string:find(LowerCase, "username"),
    ChangePos = string:find(LowerCase, "change"),
    SystemPos = string:find(LowerCase, "system"),
    HumanAssistance = string:find(LowerCase, "human"),
    case {AccountPos, PasswordPos, UsernamePos, ChangePos, SystemPos, HumanAssistance} of
        {Pos, _, _, _, _, _} when Pos /= nomatch -> account_issue;
        {_, Pos1, _, _, _, _} when Pos1 /= nomatch -> password_reset;
        {_, _, Pos1, Pos2, _, _} when Pos1 /= nomatch, Pos2 /= nomatch -> username_change;
        {_, _, _, _, Pos1, _} when Pos1 /= nomatch -> system_error;
        {_, _, _, _, _, Pos1} when Pos1 /= nomatch -> human_assistance;
        {_, _, _, _, _, _} when LowerCase =:= "exit" -> exit;
        _ -> unknown
    end.

spaces() ->
    io:format("~n~n~n").
