---
.title = "Getting Started",
.date =  "2001-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.shtml",
.tags = [],
---
# Getting Started

Ziggy is a file format so to get started you only need a text editor, but setting up a proper dev environment can make a significant difference in the quality of your experience.

## The Ziggy CLI Tool
Ziggy has a all-in-one CLI tool that gives you access to all the basics.
```
$ ziggy help

Usage: ziggy COMMAND [OPTIONS]

Commands: 
  fmt          Format Ziggy files      
  query, q     Query Ziggy files 
  check        Check Ziggy files against a Ziggy schema 
  convert      Convert between JSON, YAML, TOML files and Ziggy
  lsp          Start the Ziggy LSP
  help         Show this menu and exit

General Options:
  --help, -h   Print command specific usage
```

### Download
You can get a copy of the Ziggy CLI tool [from the releases page on GitHub](https://github.com/kristoff-it/ziggy/releases/).

Alternatively, you can compile it from source. See the README instructions for more information.

Once downloaded, you will need to put the `ziggy` executable in your `PATH` so that editors can find it.

### Next steps

Add to your editor Ziggy syntax highlighting and Ziggy LSP support by following one of the guides in the Editor Configuration section.
