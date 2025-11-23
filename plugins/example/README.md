# Example Plugin

This is an example Caddy plugin that demonstrates the basic structure of a Caddy HTTP handler plugin.

## What it does

This plugin adds a custom HTTP header `X-Example-Plugin` to all responses passing through it.

## Usage in Caddyfile

```
example "Your custom message"
```

Or simply:

```
example
```

## Example Configuration

```
:8080 {
    example "Hello from my custom plugin!"
    respond "Welcome"
}
```

## Creating Your Own Plugin

1. Copy this plugin directory structure
2. Rename the package and files
3. Update the module ID in `CaddyModule()`
4. Implement your custom logic in `ServeHTTP()`
5. Import your plugin in `main.go`
6. Rebuild the Caddy binary
