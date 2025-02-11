# Erlang Notes, Tips, and Tricks

## Introduction

Welcome to the **Erlang Notes, Tips, and Tricks** repository! This is a collection of Erlang code snippets, best practices, and explanations for educational purposes. Whether you're a beginner or an experienced Erlang developer, this guide serves as an informational textbook covering various aspects of Erlang programming.

## Contents

### 1. Concurrency and Processes

- Spawning processes (`spawn/3`)
- Sending and receiving messages (`!`, `receive`)
- Process loops for state management
- Example: **Ammo Tracker** (Managing a counter via message passing)

### 2. Functional Programming Concepts

- Pattern Matching
- Recursion
- Higher-order functions (`fun`, `map`, `foldl`, `foldr`)

### 3. Process Communication

- Using message passing for state management
- Example: **Hero Status Tracker** (Tracking health, stamina, and mana)
- Handling multiple messages in `receive`

### 4. Error Handling & Fault Tolerance

- Try/catch for error handling
- Supervisors and linking processes (`link/1`, `monitor/1`)

### 5. OTP Principles

- Understanding GenServer
- Using Supervisors
- Building fault-tolerant applications

## Example Snippets

### Spawning a Process

```erlang
start_hero() ->
    spawn(?MODULE, hero_status, [{100, 50, 50}]).
```

### Sending and Receiving Messages

```erlang
loop(Pid) ->
    Pid ! {damage, 10, self()},
    receive
        {health, NewHealth} ->
            io:format("New Health: ~p~n", [NewHealth])
    end.
```

### Process State Management

```erlang
hero_status({Health, Stamina, Mana}) ->
    receive
        {damage, Amount, From} ->
            NewHealth = max(Health - Amount, 0),
            From ! {health, NewHealth},
            hero_status({NewHealth, Stamina, Mana});
        {mana_use, Amount, From} ->
            NewMana = max(Mana - Amount, 0),
            From ! {mana, NewMana},
            hero_status({Health, Stamina, NewMana})
    end.
```

## Contribution

This project is open to contributions! If you have useful Erlang snippets or explanations, feel free to submit a pull request.

## License

This repository is for educational purposes and is open-source under the MIT license.

---

Stay tuned for more Erlang tips and tricks!
