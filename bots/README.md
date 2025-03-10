# Bots Module

## Overview

This module, `bots`, is a rule based AI chatbot written in Erlang. It interacts with users through the terminal, categorizing their queries and responding accordingly.

## Functions

### `start/0`

- Starts the chatbot.
- Greets the user and calls `loop/0` to begin interaction.

### `loop/0`

- Prompts the user for input.
- Categorizes the user’s query using `categorize_query/1`.
- Responds based on the category of the query.
- Continues interaction unless the user enters "exit".

### `categorize_query/1`

- Takes user input as a string.
- Converts it to lowercase for case-insensitive comparison.
- Identifies keywords to determine the category:
  - "account" → `account_issue`
  - "password" → `password_reset`
  - "username" & "change" → `username_change`
  - "system" → `system_error`
  - "human" → `human_assistance`
  - "exit" → Ends the interaction
  - Any other input → `unknown`

### `spaces/0`

- Prints empty lines to separate responses for better readability.

## Usage

To run the chatbot, compile the module and start it in the Erlang shell:

```erlang
c(bots).
bots:start().
```

## Example Interaction

```
Welcome! How can I help you?
-> I have an account problem
Help with account issues coming up!



Welcome! How can I help you?
-> I need a password reset
Password reset process initiated.



Welcome! How can I help you?
-> exit
Goodbye!
```

## Requirements

- Erlang runtime installed
- Erlang shell (erl) to run the module

## License

This project is open-source and available for modification and distribution.
