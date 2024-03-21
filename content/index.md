---
.title = "Home",
.date =  "2020-07-06T00:00:00",
.author = "Loris Cro",
.draft = false,
.layout = "index.html",
.tags = [],
.custom = {
    "main-sample": 
      \\.id = @uuid("..."),
      \\.time = 1710085168,
      \\.payload = Command {
      \\  .do = @action("clear_chat"),
      \\  .sender = "kristoff-it",
      \\  .roles = ["admin", "mod"],
      \\  .extra = {
      \\    "agent": "Mozilla/5.0",
      \\    "os": "Linux/x64", 
      \\  },
      \\}
      ,
    "package-schema": 
      \\root = Package
      \\
      \\///A Semantic Versioning version string.
      \\@v = bytes,
      \\///A valid SPDX expression.
      \\@spdx = bytes,
      \\
      \\struct Package {
      \\  name: bytes,
      \\  version: @v,
      \\  license: @spdx,
      \\  description: bytes,
      \\  dependencies: map[bytes],
      \\  repository: Git | Npm,
      \\}
      \\
      \\struct Git { url: bytes, directory: ?bytes }
      \\struct Npm { name: bytes }
    ,
    "message-schema": 
      \\root = Message
      \\
      \\/// A UUIDv5 value.
      \\@uuid = bytes,
      \\@action = enum { clear_chat, ban_user },
      \\
      \\struct Message {
      \\  id: @uuid,
      \\  time: int,
      \\  payload: Command | Notification,
      \\}
      \\
      \\struct Command {
      \\  do: @action,
      \\  sender: bytes,
      \\  roles: [bytes],
      \\  ///Optional metadata. 
      \\  extra: ?map[bytes],
      \\}
      \\
      \\struct Notification { text: bytes, lvl: int }

      ,
      "cli": 
      \\$ ziggy help
      \\
      \\Usage: ziggy COMMAND [OPTIONS]
      \\
      \\Commands: 
      \\  fmt          Format Ziggy files      
      \\  query, q     Query Ziggy files 
      \\  check        Check Ziggy files against a Ziggy schema 
      \\  convert      Convert between JSON, YAML, TOML files and Ziggy
      \\  lsp          Start the Ziggy LSP
      \\  help         Show this menu and exit
      \\
      \\General Options:
      \\  --help, -h   Print command specific usage
      \\
      ,
  "package-json":
      \\{
      \\  "name": "ziggy",
      \\  "version": "1.0.0",
      \\  "license": "MIT",
      \\  "dependencies": {
      \\    "react": "next",
      \\    "leftpad": "^1.0.0"
      \\  },
      \\  "repository": {
      \\    "type": "git",
      \\    "url" : "https://github.com"
      \\ },
      \\  "description": 
      \\    "# Ziggy\n\nA Data Serializa..."
      \\
      \\
      \\
      \\}
  ,

  "package-ziggy":
      \\{
      \\  .name = "ziggy",
      \\  .version = @v("1.0.0"),
      \\  .license = @spdx("MIT"),
      \\  .dependencies = {
      \\    "react": "next",
      \\    "leftpad": "^1.0.0",
      \\  },
      \\  .repository = Git {
      \\    // "type" is now the struct name
      \\    .url = "https://github.com",
      \\  },
      \\  .description = 
      \\    \\# Ziggy
      \\    \\
      \\    \\A Data Serialization Language.
      \\  ,
      \\}
  ,
  "struct": 
      \\{
      \\  .foo = "bar",
      \\  .bar = "baz",  
      \\}
  ,
  "map": 
      \\{
      \\  "foo": "bar",
      \\  "bar": "baz",  
      \\}
  ,
  
}
--- 
