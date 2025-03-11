---
.title = "Custom Types",
.date =  "2009-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Ziggy Schema Custom Types

In this section we're going to see types that require to be defined before they can be used in a type expression.

## Tagged literal

### Definition
A tagged literal can be defined in two ways:

- as an `enum`, when all possible values come from a fixed list.
- as `bytes` otherwise.

#### Enum definition
```ziggy-schema
@fruits = enum { apple, banana, cherry },
```
#### Bytes definition
It's generally a good idea to give a doc comment to byte tagged literals.

```ziggy-schema
/// A RFC3339 date literal, e.g. `2024-01-01T00:00:00`
@date = bytes,
```

### Expression
You can use the `@`-prefixed tag name to denote a tagged literal type.

Examples: `@v`, `map[@date]`, `[@fruit]`, `?@spdx`

## Struct

### Definition

Here's an example struct definion:

```ziggy-schema
///An example struct representing a person.
struct Person {
  name: bytes,
  birthday: @date,
  height: float,
  ///Null when person has no pet.
  pet_name: ?bytes,
  interests: [bytes],
}
```

In this example `Person` is the struct name. It's recommended to use TitleCase for struct names, but not mandatory.

A struct can have zero or more comma separated field definitions. A field definition is comprised of an identifier, followed by `:` and a type expression.

Both struct definitions and their fields can have an optional doc comment attached to them.

### Expression
A struct can be referenced in a type expression by its name.

Examples: `Person`, `map[Person]`, `[Command]`, `?Notification`

## Struct Union

Struct unions denote when a value can be one of two or more struct types.

Struct unions don't require to be defined beforehand but are listed in this page as they depend on at least two struct definitions to be used.

### Expression

A struct union expression is a list of `|` separated **struct names** .

When you need to make a struct union optional, you must surround it with parenthesis.  


Examples: `Command | Notification`, `map[Person | Company]`, `?(Foo | Bar)`

Example of usage in a struct definition:

```ziggy-schema
///A UUIDv4 value.
@uuid = bytes,
///Possible command actions.
@action = enum { clear_chat, ban_user },

struct Message {
  id: @uuid,
  payload: Command | Notification,
}

struct Command {
  do: @action,
  sender: bytes,
}

struct Notification {
  title: bytes,
  text: bytes,
  level: int,
}
```
