---
.title = "Document Structure",
.date =  "2007-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Ziggy Document File Structure


## File Extension
A Ziggy Document file can have either a `ziggy` or a `zgy` file extension.


## Contents
A Ziggy Document encodes one Ziggy value. A very common choice is to encode a struct in a Ziggy Document, but in fact a Ziggy Document can be an array, a map, a bytes literal or even just a single `null`.

The following are all valid Ziggy Documents:

```ziggy
"hello world"
```

```ziggy
42
```

```ziggy
{
  "this": "is",
  "a": "map",
}
```



```ziggy
[
  { .more = "structs" }, 
  { .more = "glory" },
]
```


## Top-level comment
A Ziggy file can contain an optional top-level comment block:

```ziggy
//!This is a top level comment made up of multiple lines.
//!
//!Note that this comment should not be used to document
//!the structure of this Ziggy Document, Ziggy Schemas 
//!are much better at that.

.this = "is",
.a = "braceless struct",
```


## Other comments
Ziggy allows you to put other comments in the document, but with some restrictions.

To put it simply, you're only allowed to put comments inside of structs, maps and arrays. In practice, this means that you can comment out array elements and map/struct fields.

```ziggy
.foo = bar,
//.bar = baz,
.tags = [
  "tag1",
  //can also sneak in a comment if you really want to
  //"tag2",
  "tag3",
],
```
