---
.title = "Serialization Example",
.date =  "2025-03-10T19:12:20",
.author = "LowByteFox",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---

# Serialization Example
To access the ziggy module, simply add top-level import
```zig
const ziggy = @import("ziggy");
```

## Serializing
Take a variable you would want to serialize, let's call it `foo`

`ziggy` includes a function called `stringify`, you call the function with the variable you want to serialize, configure the serializer and give it any kind of writer that implements `std.io.Writer` type

In our case we will serialize our variable into a string using `ArrayList(u8)`
Make sure you also have an `allocator` ready

```zig
var output_buffer = std.ArrayList(u8).init(allocator);
defer output_buffer.deinit();

try ziggy.stringify(foo, .{}, output_buffer.writer());
```
The function can fail, either `catch` the error or `try` and let it return the error further

The second parameter of the function can be used to configure the Serializer using `StringifyOptions`

To get our result, simply read from `output_buffer.items`
```zig
std.debug.print("{s}\n", .{output_buffer.items});
```
