-module(rec3).
-export([create_user/4, update_role/2, display_user/1]).

-record(user, {id, name = "Guest", email, role = user}).

%% Create a new user
create_user(Id, Name, Email, Role) ->
    #user{id = Id, name = Name, email = Email, role = Role}.

%% Update user role
update_role(User, NewRole) ->
    User#user{role = NewRole}.

%% Display user info
display_user(User) ->
    io:format(
        "User: ~p (~s), Email: ~s, Role: ~p~n",
        [User#user.id, User#user.name, User#user.email, User#user.role]
    ).
