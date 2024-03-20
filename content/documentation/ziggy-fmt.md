---
.title = "ziggy fmt",
.date =  "2014-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.html",
.tags = [],
---
# `ziggy fmt`

Formats Ziggy documents and Ziggy schemas.

**It's highly recommended you enable format on save in your editor to get the most out of the autoformatter.**

## Trailing Commas

Trailing commas in structs, maps, and arrays tell the autoformatter to perform vertical alignment.

Lack of a trailing comma requests horizontal alignment instead.

Given this Ziggy document:

```ziggy
.foo = "bar", .bar = [1, 
2, 3], .baz = true,
```

This is the autoformatted result:

```ziggy
.foo = "bar",
.bar = [1, 2, 3],
.baz = true,
```

- the outer struct was vertically aligned because of the trailing comma
- the array value of `bar` was horizontally aligned because there was no comma after `3`

Similar behavior also applies to Ziggy Schemas.

## Upgrading Maps

If a Ziggy document has a map value in it, you can give it a name to have `ziggy fmt` turn it into a struct. Maps cannot have names accorting to the Ziggy grammar, but the autoformatter will take that as a hint that you intend to turn a map into a struct and could you use some help.

Given this Ziggy document:
```ziggy
.foo = "bar",
.bar = {
  "arst": true,
  "qwfp": {
    "anoter": "map",
    "nested": "more deeply",
  },
}
```

Give a name to the value of `bar`:

```ziggy
.foo = "bar",
.bar = Foo {
  "arst": true,
  "qwfp": {
    "anoter": "map",
    "nested": "more deeply",
  },
}
```

On save the autoformatter will turn all map-style fields into struct-style fields: 

```ziggy
.foo = "bar",
.bar = Foo {
  .arst = true,
  .qwfp = {
    "anoter": "map",
    "nested": "more deeply",
  },
}
```
*Note how the innermost map was **not** transformed.* 

Ziggy documents are not a proprer superset of JSON because Ziggy uses a different string escape sequences, but for simple enough JSON documents you can easily upgrade them to Ziggy using this trick.

That said, for anything more than one-off transformations of trivial JSON files in your editor, you should use `ziggy convert`.
