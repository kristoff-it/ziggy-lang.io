---
.title = "Struct Unions",
.date =  "2011-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Understanding Struct Unions


## Introduction

Struct unions are possibly the best feature of Ziggy as they define a simple yet powerful sweetspot between simplicity and expressiveness of the schema language.

While on one hand we could make the schema language more powerful and give it ways of specifying more nuanced constraints, on the other we could be making it so complex that people would end up not using it as much because it becomes too tedious to write a schema.

For comparison, see this excerpt from a [JSON Schema](https://json-schema.org/), where the extreme flexibility of the language causes some schemas to devolve into pure insanity.


[]($code.asset('insanity.json').language('json').id('insanity'))


**Where JSON Schema tries to describe any possible JSON data layout, Ziggy Schema is by design only able to describe precisely only a well-defined subset of combinations.**

This is true not just of the schema language but also of some Ziggy  Document notation. For example Ziggy has structs and maps, but no notation for a key-value mapping where *some* keys are fixed, while *some others* are up to the user. It should go without saying that JSON schema [does indeed allow to model that aswell](https://json-schema.org/understanding-json-schema/reference/object#additionalproperties).

### Unions all the way down
The problem of schema expressivity is at its core a problem about expressing unions. 

A schema is a way of saying that a value can be either `A` or `B`, where both could be a a variety of things: different values (e.g. strings that belong to a list or that match a pattern), different types, structs with a given set of fields, etc. 

The more nuanced you want your *unions* to be, the more syntax and complexity you will need to pull in.

**One key consideration about this problem is that many data layouts are functionally equivalent and that guiding data layout designers towards well-understood patterns can not only help reduce the complexity of the schema language, but also of data layouts found in the wild.**


### Unions in Ziggy Schema

Consider the two following Ziggy documents which are meant to model when an application should refresh itself. In the first example we are giving to `refresh` a numeric value, indicating how many seconds should pass before a new refresh happens, while in the second case we're passing a string that represents a logic condition that must be true to trigger a refresh.

```ziggy
.refresh = 10
```
```ziggy
.refresh = "foo.bar && bar.baz"
```

This kind of data layout is fairly common in JSON, where a field can hold different types each with a different meaning. 

In Ziggy this data layout is not idiomatic and in fact Ziggy Schema can only model this *union* with `any`:

```ziggy-schema
root = App

struct App {
  refresh: any,
}
```

In Ziggy the unit of composition for unions is the struct, which means that any variant of your value must be wrapped in an appropriately-named struct.

This can be at times a mild inconvenience for data layout designers, but it has the upside of drastically diminishing the amount of syntax in the schema language and gives data layout consumers one singular language construct required to undestand layout variability.

Let's fix the previous example with this in mind:

```ziggy
.refresh = Interval {
  .seconds = 10,
},
```
```ziggy
.refresh = Condition {
  .expr = "foo.bar && bar.baz",
},
```

This is now the corresponding schema (much better):

```ziggy-schema
root = App

struct App {
  refresh: Interval | Condition,
}

struct Interval {
  seconds: int,
}

struct Condition {
  ///A logical condition that triggers a new  
  ///refresh whenever it evaluates to true.
  expr: bytes,
}
```

**By making the value of `refresh` a struct, we can achieve in Ziggy the same level of expressiveness of the original layout with even greater clarity for the end user.**

## Parser-friendly Unions

Struct unions are not only good for humans, but machines as well.

Consider this JSON document where we list some dependencies:

```json
{
  "dependencies": {
    "foo": {
      "url": "http://...",
      "hash": "..."
    },
    "bar": {
      "path": "/home/kristoff/ziggy"
    }
  }
}
```

Abstute observers will notice that dependencies in this data layout can be of two kinds: 

- remote, defined by a url and a shash value
- local, defined by a path 

Unfortunately this data layout is hostile to being parsed using tagged unions. Using Zig lingo as an example, you would like to be able to parse this document into the following kind of type:

```zig
const Dependency = union(enum) {
  Remote: struct {
    url: []const u8,
    hash: []const u8,
  },
  Local: struct {
    path: []const u8,
  },
};
```

Unfortunately this won't work with type-driven parsers as those will need to know which union case they are in *before* parsing the value of each dependency.

In this specific case the parser could notice that if the first field it finds is `path`, then it's the `Local` case, but different cases could share some fields making a general solution to this problem more problematic than what it needs to be, which in practice it means that you can't rely on parsers supporting this feature.

Some JSON data layouts make use of a `type` field to help disambiguate:


```json
{
  "dependencies": {
    "foo": {
      "type": "remote",
      "url": "http://...",
      "hash": "..."
    },
    "bar": {
      "type": "local",
      "path": "/home/kristoff/ziggy"
    }
  }
}
```

Unfortunately this approach doesn't solve the problem fully either because field order is not meaningful in JSON and so the parser can't be guaranteed that `type` will be the first field it sees.

It should be noted at this point that the problem only partially has to do with the rigidigy of statically typed languages. A language like JavaScript won't be affected by this problem because it will parse data into a dynamic object anyway, but statically typed languages can leverage type information to get dramatic performance improvements.

This means that statically typed, compiled languages could make this work by going through a dynamic value parsing phase, but the whole point of using a language of that kind is to aim for optimal behavior, which is made unreasonably harder by the lack of a tagged union construct in JSON.

The sad result is that too often people recur to creating *sausage* types, where every possible combination of fields is "minced" into a single struct type filled with optionals:

```zig
const Dependency = struct {
  url: ?[]const u8,
  hash: ?[]const u8,
  path: ?[]const u8,
};
```

Ziggy struct unions use struct names to indicate the active union case, turning the previous example into the following document:

```ziggy
.dependencies = {
  "foo": Remote {
    .url = "http://...",
    .hash = "..."
  },
  "bar": Local {
    .path = "/home/kristoff/ziggy",
  },
},
```

This has two big advantages:

- guarantees that parsers see the union case before the value
- helps the LSP provide relevant diagnostics and autocomplete without needing to guess which is the active union case

## Concrete tips
- When a key-value map has some fixed and some user-defined fields, push the latter kind of fields into a nested value of type `map`. 

  ```ziggy
  .title = "foo",
  .date = @date("2024-01-01"),
  .draft = false,
  .custom = {
    "put": "here",
    "custom": "fields",
  },
  ```
- When all variants of a struct have a common field, you might want to pull it out into the parent type definition. Not a hard rule, but can occasionally help create a better user experience.

  Good:
  ```ziggy-schema
  root = Message
  
  struct Message {
    id: bytes,
    sender: bytes,
    payload: Command | Notification,
  }

  struct Command { do: bytes }
  struct Notification { text: bytes }
  ```
  
  Arguably not as good:
  ```ziggy-schema
  root = Command | Notification

  struct Command { 
    id: bytes,
    sender: bytes,
    do: bytes 
  }
  
  struct Notification { 
    id: bytes,
    sender: bytes,
    text: bytes
  }

  ```

- Ziggy documents are more powerful than Ziggy Schema. For example this is a perfectly valid Ziggy document that can't be described precisely by a Ziggy Schema:

  ```ziggy
  ["hello", true, 42]
  ``` 

  If you're reading and writing Ziggy documents within a single application where you don't have external consumers that would benefit from a Ziggy Schema, feel free to adopt any arbitrary layout that works for you.
