---
.title = "Schema Structure",
.date =  "2010-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Ziggy Schema File Structure

## File Extension
A Ziggy Schema file can have either a `ziggy-schema` or a `zgy-schema` file extension.

## Contents
Here's an example Ziggy Schema:

```ziggy-schema
root = Message


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

A Ziggy schema is comprised of three main sections:

- the `root` definition
- a list of comma separated tag literal definitions
- a list of struct definitions

### The `root` definition
The first line of a Ziggy Schema defines what is the type of the value that corresponding Ziggy Documents encode. 

Most of the time one should expect the root value to be a struct name, but that is not always the case as a Ziggy Document can encode any possible Ziggy value, not just structs.

For example the following are all valid Ziggy Schemas:

```ziggy-schema
root = bytes
```

```ziggy-schema
root = [int]
```

```ziggy-schema
root = map[?[float]]
```

```ziggy-schema
root = [@fruit]

@fruit = enum { apple, banana, cherry },
```

### Tagged literal definitions

After the root definition follows a list of comma separated tagged literals. All tagged literals mentioned in the schema must be mentioned in that list of definitions.

```ziggy-schema
root = [Foo]

@uuid = bytes,
@date = bytes,
@fruit = enum { apple, banana, cherry },

struct Foo {
  id: @uuid,
  date: ?@date,
  fruits: [@fruit],
}
```

### Struct definitions

The final section of a Ziggy Schema file is a list of struct definitions.


```ziggy-schema
root = [A | B | C]

@uuid = bytes,

struct A {
  id: @uuid,
  foo: bytes,
}

struct B {
  id: @uuid,
  bar: bytes,
}

struct C {
  id: @uuid,
  baz: bytes,
}
```

