# Caddy Plugins Development Project

A Golang project for developing multiple Caddy plugins with Docker support for building custom Caddy binaries.

## Project Structure

```
.
├── Dockerfile              # Multi-stage Docker build for Caddy with plugins
├── docker-compose.yml      # Docker Compose configuration for easy deployment
├── Caddyfile              # Example Caddy configuration
├── main.go                # Entry point that imports Caddy and plugins
├── go.mod                 # Go module dependencies
├── go.sum                 # Go module checksums
└── plugins/               # Directory for custom plugins
    └── example/           # Example plugin
        ├── example.go     # Plugin implementation
        └── README.md      # Plugin documentation
```

## Quick Start

### Prerequisites

- Go 1.25 or later
- Docker and Docker Compose (optional, for containerized builds)

### Building Locally

1. Clone the repository:
```bash
git clone https://github.com/axomforge/caddyplugins.git
cd caddyplugins
```

2. Build the Caddy binary with plugins:
```bash
go build -o caddy
```

3. Run Caddy:
```bash
./caddy run --config Caddyfile
```

### Building with Docker

1. Build the Docker image:
```bash
docker build -t caddy-custom .
```

2. Run with Docker Compose:
```bash
docker-compose up -d
```

3. Check logs:
```bash
docker-compose logs -f
```

## Creating Your Own Plugin

1. Create a new directory under `plugins/`:
```bash
mkdir -p plugins/myplugin
```

2. Create your plugin file (e.g., `plugins/myplugin/myplugin.go`):
```go
package myplugin

import (
    "github.com/caddyserver/caddy/v2"
    "github.com/caddyserver/caddy/v2/caddyconfig/caddyfile"
    "github.com/caddyserver/caddy/v2/caddyconfig/httpcaddyfile"
    "github.com/caddyserver/caddy/v2/modules/caddyhttp"
)

func init() {
    caddy.RegisterModule(MyPlugin{})
    httpcaddyfile.RegisterHandlerDirective("myplugin", parseCaddyfile)
}

type MyPlugin struct {
    // Your plugin fields
}

// Implement required interfaces...
```

3. Import your plugin in `main.go`:
```go
import (
    _ "github.com/axomforge/caddyplugins/plugins/myplugin"
)
```

4. Rebuild:
```bash
go build -o caddy
```

## Example Plugin

This project includes an example plugin in `plugins/example/` that demonstrates:
- Plugin registration
- HTTP middleware handler
- Caddyfile configuration parsing
- Adding custom HTTP headers

To enable the example plugin:
1. Uncomment the import in `main.go`
2. Rebuild the binary
3. Use the `example` directive in your Caddyfile

## Configuration

Edit the `Caddyfile` to configure Caddy and your plugins. See the [Caddy documentation](https://caddyserver.com/docs/caddyfile) for more information.

## Development Workflow

1. **Create/Edit Plugin**: Modify files in `plugins/`
2. **Test Locally**: Build and run with `go build && ./caddy run`
3. **Build Docker Image**: `docker build -t caddy-custom .`
4. **Deploy**: Use Docker Compose or your preferred deployment method

## Accessing Caddy Admin API

The Caddy Admin API is available on port 2019:
```bash
curl http://localhost:2019/config/
```

## Adding External Plugins

To add external Caddy plugins:

1. Add the import to `main.go`:
```go
import (
    _ "github.com/example/caddy-plugin"
)
```

2. Update dependencies:
```bash
go get github.com/example/caddy-plugin
go mod tidy
```

3. Rebuild

## Resources

- [Caddy Documentation](https://caddyserver.com/docs/)
- [Writing Caddy Plugins](https://caddyserver.com/docs/extending-caddy)
- [Caddy Module Namespace](https://caddyserver.com/docs/extending-caddy/namespaces)
- [Caddyfile Directives](https://caddyserver.com/docs/caddyfile/directives)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.
