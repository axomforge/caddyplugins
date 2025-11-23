.PHONY: build clean test run docker-build docker-run help

# Build the Caddy binary with all plugins
build:
	@echo "Building Caddy with custom plugins..."
	go build -o caddy .
	@echo "Build complete: ./caddy"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -f caddy
	go clean
	@echo "Clean complete"

# Run tests (if any exist)
test:
	@echo "Running tests..."
	go test ./...

# Build and run Caddy locally
run: build
	@echo "Running Caddy..."
	./caddy run --config Caddyfile

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t caddy-custom .

# Run Caddy in Docker
docker-run: docker-build
	@echo "Starting Caddy in Docker..."
	docker-compose up -d

# Stop Docker containers
docker-stop:
	@echo "Stopping Docker containers..."
	docker-compose down

# Show Docker logs
docker-logs:
	docker-compose logs -f

# Format code
fmt:
	@echo "Formatting code..."
	go fmt ./...

# Tidy dependencies
tidy:
	@echo "Tidying dependencies..."
	go mod tidy

# List installed Caddy modules
list-modules: build
	@echo "Listing Caddy modules..."
	./caddy list-modules

# Help target
help:
	@echo "Available targets:"
	@echo "  build         - Build the Caddy binary with plugins"
	@echo "  clean         - Clean build artifacts"
	@echo "  test          - Run tests"
	@echo "  run           - Build and run Caddy locally"
	@echo "  docker-build  - Build Docker image"
	@echo "  docker-run    - Run Caddy in Docker"
	@echo "  docker-stop   - Stop Docker containers"
	@echo "  docker-logs   - Show Docker logs"
	@echo "  fmt           - Format code"
	@echo "  tidy          - Tidy dependencies"
	@echo "  list-modules  - List all Caddy modules"
	@echo "  help          - Show this help message"
