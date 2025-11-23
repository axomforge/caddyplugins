package main

import (
	caddycmd "github.com/caddyserver/caddy/v2/cmd"

	// Import Caddy core modules
	_ "github.com/caddyserver/caddy/v2/modules/standard"
	// Import custom plugins from this repository
	// Uncomment the line below when you create your first plugin
	// _ "github.com/axomforge/caddyplugins/plugins/example"
)

func main() {
	caddycmd.Main()
}
