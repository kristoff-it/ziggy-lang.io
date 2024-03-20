---
.title = "Struct Unions",
.date =  "2011-01-01T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "documentation.html",
.tags = [],
---
# Understanding Struct Unions


## Introduction

Struct unions are possibly the best feature of Ziggy as they define a simple yet powerful sweetspot between simplicity and expressiveness of the schema language.

While on one hand we could make the schema language more powerful and give it ways of specifying more nuanced constraints, on the other we could be making it so complex that people would end up not using it as much because it becomes too tedious to write a schema.

For comparison, see this excerpt from a [JSON Schema](https://json-schema.org/), where the extreme flexibility of the language causes some schemas to devolve into pure insanity.

<style id="insanity">
  style#insanity + pre {
    max-height: 400px;
    overflow-y: scroll;
  }
</style>


```json
"project": {
      "type": "object",
      "properties": {
        "cli": {
          "schematicCollections": {
            "type": "array",
            "description": "The list of schematic collections to use.",
            "items": {
              "type": "string",
              "uniqueItems": true
            }
          }
        },
        "schematics": {
          "$ref": "#/definitions/schematicOptions"
        },
        "prefix": {
          "type": "string",
          "format": "html-selector",
          "description": "The prefix to apply to generated selectors."
        },
        "root": {
          "type": "string",
          "description": "Root of the project files."
        },
        "i18n": {
          "$ref": "#/definitions/project/definitions/i18n"
        },
        "sourceRoot": {
          "type": "string",
          "description": "The root of the source files, assets and index.html file structure."
        },
        "projectType": {
          "type": "string",
          "description": "Project type.",
          "enum": ["application", "library"]
        },
        "architect": {
          "type": "object",
          "additionalProperties": {
            "$ref": "#/definitions/project/definitions/target"
          }
        },
        "targets": {
          "type": "object",
          "additionalProperties": {
            "$ref": "#/definitions/project/definitions/target"
          }
        }
      },
      "required": ["root", "projectType"],
      "anyOf": [
        {
          "required": ["architect"],
          "not": {
            "required": ["targets"]
          }
        },
        {
          "required": ["targets"],
          "not": {
            "required": ["architect"]
          }
        },
        {
          "not": {
            "required": ["targets", "architect"]
          }
        }
      ],
      "additionalProperties": false,
      "patternProperties": {
        "^[a-z]{1,3}-.*": {}
      },
      "definitions": {
        "i18n": {
          "description": "Project i18n options",
          "type": "object",
          "properties": {
            "sourceLocale": {
              "oneOf": [
                {
                  "type": "string",
                  "description": "Specifies the source locale of the application.",
                  "default": "en-US",
                  "$comment": "IETF BCP 47 language tag (simplified)",
                  "pattern": "^[a-zA-Z]{2,3}(-[a-zA-Z]{4})?(-([a-zA-Z]{2}|[0-9]{3}))?(-[a-zA-Z]{5,8})?(-x(-[a-zA-Z0-9]{1,8})+)?$"
                },
                {
                  "type": "object",
                  "description": "Localization options to use for the source locale",
                  "properties": {
                    "code": {
                      "type": "string",
                      "description": "Specifies the locale code of the source locale",
                      "pattern": "^[a-zA-Z]{2,3}(-[a-zA-Z]{4})?(-([a-zA-Z]{2}|[0-9]{3}))?(-[a-zA-Z]{5,8})?(-x(-[a-zA-Z0-9]{1,8})+)?$"
                    },
                    "baseHref": {
                      "type": "string",
                      "description": "HTML base HREF to use for the locale (defaults to the locale code)"
                    }
                  },
                  "additionalProperties": false
                }
              ]
            },
            "locales": {
              "type": "object",
              "additionalProperties": false,
              "patternProperties": {
                "^[a-zA-Z]{2,3}(-[a-zA-Z]{4})?(-([a-zA-Z]{2}|[0-9]{3}))?(-[a-zA-Z]{5,8})?(-x(-[a-zA-Z0-9]{1,8})+)?$": {
                  "oneOf": [
                    {
                      "type": "string",
                      "description": "Localization file to use for i18n"
                    },
                    {
                      "type": "array",
                      "description": "Localization files to use for i18n",
                      "items": {
                        "type": "string",
                        "uniqueItems": true
                      }
                    },
                    {
                      "type": "object",
                      "description": "Localization options to use for the locale",
                      "properties": {
                        "translation": {
                          "oneOf": [
                            {
                              "type": "string",
                              "description": "Localization file to use for i18n"
                            },
                            {
                              "type": "array",
                              "description": "Localization files to use for i18n",
                              "items": {
                                "type": "string",
                                "uniqueItems": true
                              }
                            }
                          ]
                        },
                        "baseHref": {
                          "type": "string",
                          "description": "HTML base HREF to use for the locale (defaults to the locale code)"
                        }
                      },
                      "additionalProperties": false
                    }
                  ]
                }
              }
            }
          },
          "additionalProperties": false
        },
        "target": {
          "oneOf": [
            {
              "$comment": "Extendable target with custom builder",
              "type": "object",
              "properties": {
                "builder": {
                  "type": "string",
                  "description": "The builder used for this package.",
                  "not": {
                    "enum": [
                      "@angular-devkit/build-angular:application",
                      "@angular-devkit/build-angular:app-shell",
                      "@angular-devkit/build-angular:browser",
                      "@angular-devkit/build-angular:browser-esbuild",
                      "@angular-devkit/build-angular:dev-server",
                      "@angular-devkit/build-angular:extract-i18n",
                      "@angular-devkit/build-angular:karma",
                      "@angular-devkit/build-angular:ng-packagr",
                      "@angular-devkit/build-angular:prerender",
                      "@angular-devkit/build-angular:jest",
                      "@angular-devkit/build-angular:web-test-runner",
                      "@angular-devkit/build-angular:protractor",
                      "@angular-devkit/build-angular:server",
                      "@angular-devkit/build-angular:ssr-dev-server"
                    ]
                  }
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "type": "object"
                },
                "configurations": {
                  "type": "object",
                  "description": "A map of alternative target options.",
                  "additionalProperties": {
                    "type": "object"
                  }
                }
              },
              "additionalProperties": false,
              "required": ["builder"]
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:application"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/application/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/application/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:app-shell"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/app-shell/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/app-shell/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:browser"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/browser/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/browser/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:browser-esbuild"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/browser-esbuild/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/browser-esbuild/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:dev-server"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/dev-server/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/dev-server/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:extract-i18n"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/extract-i18n/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/extract-i18n/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:karma"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/karma/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/karma/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:jest"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/jest/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/jest/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:web-test-runner"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/web-test-runner/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/web-test-runner/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:protractor"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/protractor/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/protractor/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:prerender"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/prerender/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/prerender/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:ssr-dev-server"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/ssr-dev-server/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/ssr-dev-server/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:server"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/server/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/server/schema.json"
                  }
                }
              }
            },
            {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "builder": {
                  "const": "@angular-devkit/build-angular:ng-packagr"
                },
                "defaultConfiguration": {
                  "type": "string",
                  "description": "A default named configuration to use when a target configuration is not provided."
                },
                "options": {
                  "$ref": "../../../../angular_devkit/build_angular/src/builders/ng-packagr/schema.json"
                },
                "configurations": {
                  "type": "object",
                  "additionalProperties": {
                    "$ref": "../../../../angular_devkit/build_angular/src/builders/ng-packagr/schema.json"
                  }
                }
              }
            }
          ]
        }
      }
    },
```

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
