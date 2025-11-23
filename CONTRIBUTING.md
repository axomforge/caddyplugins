# Contributing to Caddy Plugins

Thank you for your interest in contributing to this Caddy plugins project! This document provides guidelines and instructions for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR-USERNAME/caddyplugins.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes
6. Commit and push to your fork
7. Create a Pull Request

## Development Setup

### Prerequisites

- Go 1.25 or later
- Docker (optional, for containerized testing)
- Make (optional, for using Makefile targets)

### Building the Project

```bash
# Using Make
make build

# Or directly with Go
go build -o caddy .
```

### Running Tests

```bash
# Run all tests
make test

# Or directly with Go
go test ./...
```

## Creating a New Plugin

1. Create a new directory under `plugins/`:
   ```bash
   mkdir -p plugins/yourplugin
   ```

2. Create your plugin file following the Caddy plugin conventions:
   ```go
   package yourplugin
   
   import (
       "github.com/caddyserver/caddy/v2"
       "github.com/caddyserver/caddy/v2/caddyconfig/caddyfile"
       "github.com/caddyserver/caddy/v2/caddyconfig/httpcaddyfile"
       "github.com/caddyserver/caddy/v2/modules/caddyhttp"
   )
   
   func init() {
       caddy.RegisterModule(YourPlugin{})
       httpcaddyfile.RegisterHandlerDirective("yourplugin", parseCaddyfile)
   }
   
   // Implement your plugin...
   ```

3. Import your plugin in `main.go`:
   ```go
   _ "github.com/axomforge/caddyplugins/plugins/yourplugin"
   ```

4. Add documentation in a README.md file in your plugin directory

5. Add tests for your plugin (recommended)

## Code Style

- Follow standard Go formatting: `go fmt ./...`
- Follow Go best practices and idioms
- Add comments for exported functions and types
- Keep functions focused and concise

## Testing Guidelines

- Write unit tests for your plugin logic
- Test Caddyfile parsing if applicable
- Test error conditions
- Aim for good test coverage

## Pull Request Process

1. Ensure your code builds successfully
2. Run all tests and ensure they pass
3. Update documentation if needed
4. Update the README if you're adding a new plugin
5. Create a clear PR description explaining:
   - What changes you made
   - Why you made them
   - How to test the changes

## Plugin Requirements

When contributing a new plugin, please ensure:

- [ ] Plugin follows Caddy's plugin conventions
- [ ] Plugin is properly registered in `init()`
- [ ] Plugin implements required interfaces
- [ ] Plugin includes a README with usage examples
- [ ] Plugin is imported in `main.go`
- [ ] Code is formatted with `go fmt`
- [ ] Tests are included (if applicable)

## Commit Message Guidelines

- Use clear, descriptive commit messages
- Start with a verb in present tense (e.g., "Add", "Fix", "Update")
- Keep the first line under 50 characters
- Add detailed description in the commit body if needed

Examples:
- `Add rate limiting plugin`
- `Fix header parsing in example plugin`
- `Update documentation for custom plugins`

## Resources

- [Caddy Documentation](https://caddyserver.com/docs/)
- [Writing Caddy Plugins](https://caddyserver.com/docs/extending-caddy)
- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)

## Questions or Issues?

Feel free to open an issue if you have questions or run into problems. We're here to help!

## License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project.
