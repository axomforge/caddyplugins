# Build stage
FROM golang:1.25-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Set working directory
WORKDIR /build

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build Caddy with plugins
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o caddy .

# Final stage
FROM alpine:latest

# Install runtime dependencies
RUN apk --no-cache add ca-certificates tzdata

# Create a non-root user
RUN addgroup -g 1000 caddy && \
    adduser -D -u 1000 -G caddy caddy

# Copy the binary from builder
COPY --from=builder /build/caddy /usr/bin/caddy

# Copy Caddyfile if exists
COPY --chown=caddy:caddy Caddyfile /etc/caddy/Caddyfile

# Create directories for Caddy
RUN mkdir -p /data/caddy /config/caddy && \
    chown -R caddy:caddy /data /config

# Switch to non-root user
USER caddy

# Expose ports
EXPOSE 80 443 2019

# Set working directory
WORKDIR /

# Set environment variables
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

# Run Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
