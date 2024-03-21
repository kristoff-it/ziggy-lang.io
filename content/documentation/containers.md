---
.title = "Ziggy Container Value Types",
.date =  "2006-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.html",
.tags = [],
---
# Ziggy Container Value Types
## Arrays
Ziggy uses `[]` (square brakets) to denote arrays. An array can contain zero or more elements separated by commas. Trailing commas are allowed.

Ziggy arrays can contain different types of values and can be nested arbitrarily deep.

Examples: `[1, 2, 3]`, `[true, null, 42]`, `["hello", [1], []]`

## Maps
Maps are the first key-value mapping notation available in Ziggy.

Maps are meant to denote key-value mappings where key names are controlled **by the user**.

It's common for configuration files and API messages to have key-value mappings where key names are meant to be part of a schema, while some other key-value mappings are instead meant to be fully controlled by the user. 

One example of this is NPM's `package.json`:
```json
{
  "name": "ziggy",
  "dependencies": {
    "react": "next",
    "leftpad": "^1.0.0"
  }
}
```

In this example you can see how `"name"` and `"dependencies"` are part of a schema, while dependency names are up to the user. In Ziggy the outer key-value mapping would be represented as a struct, while `"dependencies"` would be a map.

Ziggy map syntax looks like this:
```ziggy
{
  "hello": "world",
  "foo": true,
}
```

Ziggy maps have the same notation as JSON objects but allow trailing commas.

A hypotetical `package.ziggy`, where the outer key-value map is expressed as a struct, would look like this:

```ziggy
{
  .name = "ziggy",
  .dependencies = {
    "react": "next",
    "leftpad": "^1.0.0",
  },
}
```


## Structs
Structs are the second key-value mapping notation available in Ziggy.
Structs are meant to denote key-value mappings where key names are controlled **by the application** (i.e. must follow a schema).

Judicious use of struct syntax should help users understand the data layout even before they reach for a Ziggy Schema or some other kind of documentation.

Basic struct syntax looks like this:
```ziggy
{
  .hello = "world",
  .foo = true,
}
```
*NOTE: like arrays and maps, structs also allow trailing commas.*

### Omitting top-level curlies
When a Ziggy document has a top-level value of type struct, the outer curlies can be omitted to reclaim one level of indentation. This syntactical trick helps making Ziggy a more suitable language for config files and Markdown frontmatters.

This is the same as the previous example:
```ziggy
.hello = "world",
.foo = true,
```

### Named structs
Structs can have a name attached to them. 

This feature is particularly useful when used in conjunction with Ziggy Schemas to define **struct unions**.

```ziggy
{
    .name = "Ziggy",
    .dependencies = {
        "foo": Remote {
            .url = "https://github.com/",
            .hash = "123abcdef",  
        },
        "bar": Local {
            .path = "foo/bar/baz",
        }
    },
}
```

