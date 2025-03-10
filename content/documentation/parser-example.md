---
.title = "Parser Example",
.date =  "2025-03-10T19:11:59",
.author = "LowByteFox",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---

# Parser Example
To access the ziggy module, simply add top-level import
```zig
const ziggy = @import("ziggy");
```
The parser API is now accessible through `ziggy.Parser`

## Parsing a string
First, define a type you want ziggy schema to reflect
```zig
const Example = struct {
    foo: []const u8,
    bar: bool,
};
```
Make sure you also have an `allocator` and a string to parse ready

`ziggy.Parser` includes a function called `parseLeaky`, you can call the function, and it will return instance of your type from the parsed string
```zig
const example = try ziggy.Parser.parseLeaky(Example, allocator, str, .{});
```
Now you can access the data through the returned value

The function can fail, either `catch` the error or `try` and let it return the error further

Last parameter of the function can be used to configure the parser using `ParseOptions` 

It is recommended to use `std.heap.ArenaAllocator` instead, as the function could possibly leak memory
