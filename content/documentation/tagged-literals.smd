---
.title = "Tagged Literals",
.date =  "2012-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Tagged Literals

In the previous page we discussed struct unions, which come with some benefits for humans and also some benefits for parsers, especially when it comes statically typed, compiled languages.

Tagged literals also bring their own set of benefits for users but in some ways are the inverse of struct unions, as they mainly cater to dynamically typed languages. 

## What are tagged literals for?

Tagged literals offer two main benefits:

- give a hint to the user about expected data formats
- help parsers map strings to other data types

It is important to understand these benefits in the context of a fully fledged use case, otherwise we risk overusing (or underusing) this tool.

## Use Case: Chat Message
Consider this very simple chat message example:

```ziggy
.sent_at = "2024-01-01T00:00:00",
.text = "hello world",
```

Should `date` be turned into a tagged literal? Let's look at the practical implications of doing so to make a decision.

- **No** tagged literal
  ```ziggy-schema
  root = Message 

  struct Message {
    ///A RFC3339 date string, eg `2024-01-01T00:00:00`
    sent_at: bytes,
    ///Message contents
    text: bytes,
  }
  ```

- Tagged literal
  ```ziggy-schema
  root = Message 

  ///A RFC3339 date string, eg `2024-01-01T00:00:00`
  @date = bytes,

  struct Message {
    sent_at: @date,
    ///Message contents
    text: bytes,
  }
  ```


As you can see, in this very simple case there isn't much to gain by introducing a tagged literal.

This is mainly caused by the fact that there is only one field that holds a date, so we ended up moving the docstring from one place to the other, with little difference to the overal result.

It should be noted that looking at how this choice influences the resulting Ziggy Schema does not tell you the full picture, and in fact later on we will focus on parsing, but for now let's keep looking at Ziggy Schemas a bit more.

Let's take a look now at an example where a date literal would be more compelling.


## Use Case: Job Posting
Consider this Ziggy document:

```ziggy
.title = "Hot Startup wants Senior Zig Engineer",
.creation_date = @date("2024-01-01"),
.publish_date = @date("2024-01-10"),
.expiry_date = @date("2024-02-10"),
.text = "Hot Startup...",
```

Let's look again at the schema with and without tagged literals:

- **No** tagged literal
  ```ziggy-schema
  root = Message 

  struct Message {
    ///Title of this job posting
    title: bytes,
    ///Date this job posting was created, in 'YYYY-MM-DD' format.
    creation_date: bytes,
    ///Date this job posting becomes visible, in 'YYYY-MM-DD' format.
    publish_date: bytes,
    ///Date this job posting goes offline, in 'YYYY-MM-DD' format.
    expiry_date: bytes,
    ///Main content
    text: bytes,
  }
  ```

- Tagged literal
  ```ziggy-schema
  root = Message 
  
  ///A date in 'YYYY-MM-DD' format.
  @date = bytes,

  struct Message {
    ///Title of this job posting
    title: bytes,
    ///Date this job posting was created.
    creation_date: @date,
    ///Date this job posting becomes visible.
    publish_date: @date,
    ///Date this job posting goes offline.
    expiry_date: @date,
    ///Main content
    text: bytes,
  }
  ```

In contrast with the Chat message use case, this second example shows how by creating a dedicated tagged literal to express dates, we were able to collect all repeated date format requirements into one place.

## Parsing From Dynamic Languages
In the "Struct Unions" page we mentioned how statically typed, compiled languages benefit from Ziggy struct unions more than dynamic languages.

If those kind of languages aim to approximate optimal behavior from the machine, dynamic languages in contrast are more about letting the programmer leave details unstated in order to achieve faster development speed.

One clear example of this differerence is how in Zig (statically typed, compiled and generally low-level) the programmer always wants to have a type definition for Ziggy data layouts, while in JavaScript (dynamic, interpreted, high-level) one can easily get away with parsing Ziggy documents on the fly.

And it's in this second scenario that string literals offer the right amount of typization.

Ziggy doesn't have yet a JavaScript parser library, so the following code is not a *concrete* example, but it's still a valid way of showing how tagged literals are useful in that scenario:

```javascript
// Imaginary "ziggy" package.
const ziggy = require("ziggy");

const posting = ziggy.parse("posting.ziggy", {
  // Date.parse accepts an ISO8601 date string 
  // and returns a date instance.
  literals: { date: Date.parse },
});
```

With just one (imaginary but plausible) line we were able to parse dates correctly. Without a date literal, it wouldn't be this easy.

## Not Just Dynamic Languages
The example given just now revolved around the ability to recognize dates (as an example of tagged literal) inside of an unknown data layout. In that example, what made the data layout "unknown" was the interest in leaving it unspecified inside of a JavaScript application.

There is one last situation worth considering that involves unknown layouts: when a data layout accepts user-defined fields.

One prime example of this use case are frontmatters.

A frontmatter is a small section of metadata (usually expressed in YAML) placed at the top of Markdown files, usually consumed by static site generators while rendering the content into HTML files.
This is what it looks like in [Zine](https://zine-ssg.io):
```markdown
---
.title = "Tagged Literals",
.date = @date("2024-03-20T00:00:00"),
.author = "Loris Cro",
.layout = "documentation.html",
.draft = false,
---
# Tagged Literals

Yadda yadda...
```

In Zine it's also possible to specify custom fields inside of the frontmatter of each page, which can then be retrieved from the HTML layout in order to orchestrate rendering logic. 

Let's consider an example where we want to use Zine to render a ticket sales page (for simplicity let's focus on the frontmatter itself):

```ziggy
.title = "Buy Tickets",
.layout = "tickets.html",
.draft = false,
.custom = {
  "sale_start": @date("2024-01-01T00:00:00"),
  "sale_end": @date("2024-04-01T00:00:00"),
},
```

In this case `sale_start` and `sale_end` are two custom fields provided by the user that don't belong to the Zine frontmatter schema.

This means that even though Zine is an application written in Zig, for all intents and purposes, we are in a similar situation to where JavaScript was, when it comes to parsing contents of the `custom` field.

Zine leverages tagged unions in order to recognize when a user-provided field is meant to represent a date, which brings a couple practical benefits:

- the user doesn't have to parse a date out of a string everytime they want to access custom date fields
- a malformed date will result in a frontmatter parsing error, instead of a template evaluation error




## Concrete Tips

The goldern rule of tagged literals (and maybe of a few other things as well):

**Abstract purity doesn't belong in engineering.**,

**Resist always the temptation of creating tagged literals for abstract reasons. Always think of the practical implications and act exclusively in accordance to the intent of achieving a practical outcome.**


### Manual editing or automated generation?
If your Ziggy data layout is going to be edited by humans manually (e.g. it's a config file format), then they might benefit from the [affordance](https://en.wikipedia.org/wiki/Affordance) offered by a tagged literal, like dedicated documentation and autocomplete suggestions. Although you should also keep in mind that if your literal is only used in one place, then a field doc comment might suffice (like in the chat message use case).

If your data layouts are instead designed to be consumed by programs (e.g. API messages), then the previous point become much weaker and you will want to leverage other considerations in order to make a final decision.

### Who will consume your data layout?
If your Ziggy data layout might be consumed by clients implemented in dynamic languages, they might want to parse your Ziggy documents without hardcoding a schema in their code, and in that case tagged literals could help them improve their parsing experience.

If your data layouts are instead going to be consumed exclusively by statically typed, compiled, low-level languages, then you will want to leverage other considerations in order to make a final decision.

### Do you have user-provided fields?
If you Ziggy data layout accepts user-provided fields, and users are allowed to input strings that represent types understood by your application (e.g. dates) then you have a good reason to defne those types as tagged literals.

It should be noted that this last point should still be evaluated in light of the "avoid abstract purity" principle. It's often the case that applications must deal with many literals, like `@url` or `@path` for example, but that doesn't immediately mean that one should create literals for each.

The Zine frontmatter example was relevant precisely because by recognizing dates early the user experience got improved. If creating a tagged literal for a type doesn't trigger the same kind of practical improvement, it might be best to prefer creating a simpler schema in order to gain the very real benefit of lowering the cognitive load on your users. 
