---
.title = "Builtin Types",
.date =  "2008-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Ziggy Schema Builtin Types

## Type keywords
Ziggy Schemas have two keywords for expressing that a value can be of any possible type:

- `any`
- `unknown`

The difference between the two keywords requires first introducing more concepts, so we will return on this topic in the "Schema Structure" page.

For now, suffice to say that `any` should be the preferred keyword to use whenever a more precise type expression could not be found.

## Basic types
Ziggy Schemas have a type name for all basic Ziggy scalar literals. 

- `int` for an integer literal
- `float` for a float literal (integer literals can be coerced) 
- `bool` for `true` or `false`
- `bytes` for a bytes literal

Note that Ziggy multiline bytes literals don't have a corresponding type name. As far as the schema language is concerned, the two are different notations for the same type. 

Language libraries will ideally offer their users ways to opt into serializing byte sequences into double quoted or multiline literals. The Zig implementation for example will default to multiline literals when a string contains newlines and no `\xNN` escape sequences.

## Optionals
When a Ziggy value can be `null`, you can use the `?T` notation to define an optional type, where `T` is a type expression.

Note that you can't nest optionals directly. `??bytes` is invalid, for example.

Examples: `?bytes`, `?int`

## Arrays
Ziggy arrays can be defined using the `[T]` notation, where `T` is a type expression.

Examples: `[?bytes]`, `[[bool]]`

## Maps
Ziggy maps can be defined using the `map[T]` notation, where `T` is a type expression.

Examples: `map[bytes]`, `map[bool]`, `map[?[bytes]]`


## What About Heterogeneous Arrays And Maps?

Ziggy documents can indeed express heterogeneous collections:

```ziggy
["hi", true, 42]
```
```ziggy
{
  "foo": "bar",
  "bar": true,
  "baz": 42,
}
```

But Ziggy Schema can at best represent those types as `[any]` and `map[any]`. While you are certainly allowed to create Ziggy documents of this kind, in situations where you have external consumers that could benefit from a Ziggy Schema, you are *gently* encouraged by the language to use structs to express type variablily.

The "Design Tips" section will expand on this point.
