package example

import (
	"net/http"

	"github.com/caddyserver/caddy/v2"
	"github.com/caddyserver/caddy/v2/caddyconfig/caddyfile"
	"github.com/caddyserver/caddy/v2/caddyconfig/httpcaddyfile"
	"github.com/caddyserver/caddy/v2/modules/caddyhttp"
)

func init() {
	caddy.RegisterModule(ExamplePlugin{})
	httpcaddyfile.RegisterHandlerDirective("example", parseCaddyfile)
}

// ExamplePlugin is a simple example Caddy plugin
type ExamplePlugin struct {
	Message string `json:"message,omitempty"`
}

// CaddyModule returns the Caddy module information.
func (ExamplePlugin) CaddyModule() caddy.ModuleInfo {
	return caddy.ModuleInfo{
		ID:  "http.handlers.example",
		New: func() caddy.Module { return new(ExamplePlugin) },
	}
}

// Provision implements caddy.Provisioner.
func (e *ExamplePlugin) Provision(ctx caddy.Context) error {
	if e.Message == "" {
		e.Message = "Hello from Example Plugin!"
	}
	return nil
}

// Validate implements caddy.Validator.
func (e *ExamplePlugin) Validate() error {
	return nil
}

// ServeHTTP implements caddyhttp.MiddlewareHandler.
func (e ExamplePlugin) ServeHTTP(w http.ResponseWriter, r *http.Request, next caddyhttp.Handler) error {
	w.Header().Set("X-Example-Plugin", e.Message)
	return next.ServeHTTP(w, r)
}

// UnmarshalCaddyfile implements caddyfile.Unmarshaler.
func (e *ExamplePlugin) UnmarshalCaddyfile(d *caddyfile.Dispenser) error {
	for d.Next() {
		if d.NextArg() {
			e.Message = d.Val()
		}
	}
	return nil
}

// parseCaddyfile sets up the handler from Caddyfile tokens.
func parseCaddyfile(h httpcaddyfile.Helper) (caddyhttp.MiddlewareHandler, error) {
	var e ExamplePlugin
	err := e.UnmarshalCaddyfile(h.Dispenser)
	return e, err
}

// Interface guards
var (
	_ caddy.Provisioner           = (*ExamplePlugin)(nil)
	_ caddy.Validator             = (*ExamplePlugin)(nil)
	_ caddyhttp.MiddlewareHandler = (*ExamplePlugin)(nil)
	_ caddyfile.Unmarshaler       = (*ExamplePlugin)(nil)
)
